Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315276AbSHVR1h>; Thu, 22 Aug 2002 13:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315337AbSHVR1h>; Thu, 22 Aug 2002 13:27:37 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:39155 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315276AbSHVR1c>; Thu, 22 Aug 2002 13:27:32 -0400
Subject: Re: 2.4 kernel series and the oom_killer and
	/proc/sys/vm/overcommit_memory
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marc-Christian Petersen <m.c.p@gmx.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200208221719.50568.m.c.p@gmx.net>
References: <200208221719.50568.m.c.p@gmx.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 22 Aug 2002 18:32:53 +0100
Message-Id: <1030037573.3090.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-22 at 16:19, Marc-Christian Petersen wrote:
> If I understand it correct, /proc/sys/vm/overcommit_memory controls if there 
> is "1" always enough memory and if "0" every program call checks if there is 
> enough memory.

No

0 is a heuristic overcommit
1 is "anything goes"

and with a -ac kernel

2 is a proper overcommit manager
3 is a totally paranoid one that will require everything in ram can be
dumped to swap or paged back from backing store

