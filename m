Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286306AbRLJQ3E>; Mon, 10 Dec 2001 11:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286307AbRLJQ2z>; Mon, 10 Dec 2001 11:28:55 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:2821 "EHLO mail3.aracnet.com")
	by vger.kernel.org with ESMTP id <S286306AbRLJQ2m>;
	Mon, 10 Dec 2001 11:28:42 -0500
From: "M. Edward Borasky" <znmeb@aracnet.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.16 memory badness (fixed?) 
Date: Mon, 10 Dec 2001 08:29:05 -0800
Message-ID: <HBEHIIBBKKNOBLMPKCBBOEHNEDAA.znmeb@aracnet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <200112101549.fBAFnOq08395@orp.orf.cx>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> I just can't understand why the kernel wouldn't tag application memory
> as being more important than buff/cache and free up some of that stuff
> when an application calls for it. I mean, it won't even use the gobs of
> swap I have. That just seems to be a plain ol' bug to me.

It's not strictly a bug ... it's a design decision that has unfortunate
consequences. A simple fix would be to allow the system administrator to set
an upper limit on the size of the page cache.
--
M. Edward Borasky
znmeb@@borasky-research.net
http://www.borasky-research.net

