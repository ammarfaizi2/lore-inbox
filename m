Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318225AbSHIKhc>; Fri, 9 Aug 2002 06:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318231AbSHIKhb>; Fri, 9 Aug 2002 06:37:31 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:55293 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318225AbSHIKhb>; Fri, 9 Aug 2002 06:37:31 -0400
Subject: Re: 2.4.19 crash
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michal Illich <michal@illich.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D53931A.7060300@illich.cz>
References: <3D53931A.7060300@illich.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 09 Aug 2002 13:01:25 +0100
Message-Id: <1028894485.28882.208.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-09 at 11:02, Michal Illich wrote:
> Happened again, now with "kernel BUG at buffer.c:510!" message.
> Everything same as before, except:
> (a) kernel was recompiled without high memory option
> (b) machine was running but not responding at all (no ping)
> Seems quite serious to me, any ideas?

Looks very much like random memory corruption. Could be many things.
Does the box pass memtest86 ?

