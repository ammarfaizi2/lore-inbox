Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318994AbSHSTSo>; Mon, 19 Aug 2002 15:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318995AbSHSTSo>; Mon, 19 Aug 2002 15:18:44 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:6649 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318994AbSHSTSm>; Mon, 19 Aug 2002 15:18:42 -0400
Subject: Re: A question about cache coherence
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Xuehua Chen <namniardniw@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020819182121.93059.qmail@web13008.mail.yahoo.com>
References: <20020819182121.93059.qmail@web13008.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 19 Aug 2002 20:23:03 +0100
Message-Id: <1029784983.19758.50.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-19 at 19:21, Xuehua Chen wrote:
> 1. Do Xeon processors have hardware mechanisms to
> maintain cache coherence?

Yes

> 2. Does the SMP kernel handle the cache coherence
> problem

The kernel has to manage side issues (TLB shootdown etc)

> 3. What should I do if both of them don't handle cache
> coherence.

Debug your code. It is possible you are hitting a kernel bug but its
extremely unlikely.

