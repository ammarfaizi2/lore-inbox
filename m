Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264853AbRGNTyq>; Sat, 14 Jul 2001 15:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264856AbRGNTyg>; Sat, 14 Jul 2001 15:54:36 -0400
Received: from demai05.mw.mediaone.net ([24.131.1.56]:56245 "EHLO
	demai05.mw.mediaone.net") by vger.kernel.org with ESMTP
	id <S264853AbRGNTy2>; Sat, 14 Jul 2001 15:54:28 -0400
Message-Id: <200107141954.f6EJsUS09999@demai05.mw.mediaone.net>
Content-Type: text/plain; charset=US-ASCII
From: Gabriel Friedmann <gfriedmann@mediaone.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Again: Linux 2.4.x and AMD Athlon
Date: Sat, 14 Jul 2001 15:54:22 -0400
X-Mailer: KMail [version 1.2.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas,  try recompiling your kernel with the  3dnow optimization line 
commented out in arch/i386/config.in  .  

This has solved the crashes for me, but in my case, they are more severe.

I believe Alan has already commented on VIA problems and the problems with 
their chipsets.. ahh, found it 
"We believe its a VIA chipset problem. Don't expect anything to happen on 
this front"

This bums me out.  AS i am using ABIT kt7a-raid with the kt133a chipset, and 
3dnow kernel optimizations and i oops right as i boot (sometimes before i 
complete any init-scripts).

Anyways...  I am confirming a problem with my via chipset and 3dnow 
optimizations.  VIA82CXXX in kernel support not affecting outcome.

Gabriel Friedmann

Let me know if i don't make sense.
