Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317335AbSFLVai>; Wed, 12 Jun 2002 17:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317203AbSFLVag>; Wed, 12 Jun 2002 17:30:36 -0400
Received: from opus.INS.CWRU.Edu ([129.22.8.2]:51425 "EHLO opus.INS.cwru.edu")
	by vger.kernel.org with ESMTP id <S314277AbSFLVad>;
	Wed, 12 Jun 2002 17:30:33 -0400
From: "Braden McGrath" <bwm3@po.cwru.edu>
To: "'Samuel Flory'" <sflory@rackable.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: PROBLEM: Kernel 2.4.18 Promise driver (IDE) hangs @ boot withPromise 20267
Date: Wed, 12 Jun 2002 17:32:55 -0400
Message-ID: <006f01c21258$b72a7430$ceaa1681@z>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <1023891585.8847.181.camel@flory.corp.rackablelabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   You might try Alan Cox's ac kernel.  2.4.19pre10ac2 seems 
> to work bit better on the Promise controllers for me.  You 
> will need to patch in 2.4.19pre10, and then 2.4.19pre10ac2.
> 
> http://www.us.kernel.org/pub/linux/kernel/v2.4/testing/
>
http://www.us.kernel.org/pub/linux/kernel/people/alan/linux-2.4/2.4.19/

Thanks, I'll give it a try... Will I experience any problems trying to
get XFS into this kernel as well?  I start with 2.4.18 to patch to the
pre* series, correct?  (I'm not used to running bleeding edge...)  I'm
guessing the order would be:
2.4.18 (stock)
+XFS
+.19pre10
+pre10ac2

> PS- What of the PDC options are you using?  I generally enable the
> following:
> CONFIG_BLK_DEV_PDC202XX=y
> CONFIG_PDC202XX_BURST=y
> CONFIG_PDC202XX_FORCE=y

CONFIG_BLK_DEV_PDC202XX=y  (at least in the problematic kernel, this
enables the subdriver itself)
CONFIG_PDC202XX_BURST=y,n  (I've tried both, neither helps)
CONFIG_PDC202XX_FORCE=n    (I read that this is for FastTrak
controllers, I only have an Ultra100)

Thanks, I'll try this when I get home!

--Braden

