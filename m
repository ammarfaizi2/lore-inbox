Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135395AbREBEb5>; Wed, 2 May 2001 00:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135404AbREBEbh>; Wed, 2 May 2001 00:31:37 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:2309 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S135395AbREBEbc>; Wed, 2 May 2001 00:31:32 -0400
Message-Id: <200105020431.f424VPs81767@aslan.scsiguy.com>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.3 2.4.4pre8: aic7xxx showstopper bug fails to detect sda 
In-Reply-To: Your message of "Mon, 30 Apr 2001 01:39:56 +0200."
             <20010430013956.A1578@emma1.emma.line.org> 
Date: Tue, 01 May 2001 22:31:25 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Since the official aic7xxx site doesn't carry a patch against 2.4.4 yet
>(just 2.4.3) which has cosmetic issues when being patched, I made a
>patch against 2.4.4: I took the 2.4.3-aic7xxx-6.1.12 patch, applied to
>2.4.4, bumped the version to read -ma1 in EXTRAVERSION, and made a new
>patch against vanilla 2.4.4, to be found at:

Version 6.1.13 of my aic7xxx driver is now up.  I've included
patches to 2.4.4 and 2.4.4-ac2.  If this version still causes
problems for you, please boot with "aic7xxx=verbose" and send
me any diagnostic output the driver prints.  I'll try to correct
your issue as quickly as I can.

--
Justin
