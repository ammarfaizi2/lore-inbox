Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310285AbSCBCuO>; Fri, 1 Mar 2002 21:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310292AbSCBCty>; Fri, 1 Mar 2002 21:49:54 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:6397
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S310285AbSCBCto>; Fri, 1 Mar 2002 21:49:44 -0500
Date: Fri, 1 Mar 2002 18:50:13 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre2-ac1
Message-ID: <20020302025013.GA1600@matchmail.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E16gyy2-0005oW-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16gyy2-0005oW-00@the-village.bc.nu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 02, 2002 at 02:09:46AM +0000, Alan Cox wrote:
> This one is a bit more experimental. I've avoided putting too much in so
> we can see how the O(1) scheduler pans out.
> 

--- linux.19p2/Makefile Fri Mar  1 18:26:30 2002
+++ linux.19pre2-ac1/Makefile   Fri Mar  1 18:41:22 2002
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 4
 SUBLEVEL = 19
-EXTRAVERSION = -pre2
+EXTRAVERSION = -pre1-ac3
 
 KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)

Ehh, a little problem here. :(

It does apply and compile on top of pre2, but uname -r will say different.

Mike
