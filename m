Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130110AbQKRSKg>; Sat, 18 Nov 2000 13:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130145AbQKRSKQ>; Sat, 18 Nov 2000 13:10:16 -0500
Received: from 13dyn189.delft.casema.net ([212.64.76.189]:10 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S130110AbQKRSKQ>; Sat, 18 Nov 2000 13:10:16 -0500
Message-Id: <200011181740.SAA14504@cave.bitwizard.nl>
Subject: Re: EXPORT_NO_SYMBOLS vs. (null) ?
In-Reply-To: <E13xBXm-0001s7-00@the-village.bc.nu> from Alan Cox at "Nov 18,
 2000 05:12:49 pm"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Sat, 18 Nov 2000 18:40:07 +0100 (MET)
CC: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > What is the difference between a module that exports no symbols and
> > includes EXPORT_NO_SYMBOLS reference, and such a module that lacks
> > EXPORT_NO_SYMBOLS?
> > 
> > Alan once upbraided me for assuming they were the same :)
> 
> EXPORT_NO_SYMBOLS		-	nothing exported
> MODULE_foo			-	export specific symbol
> 
> none of the above, export all globals but without modvers
                                ^^^^^^^ and statics!!!!

I consider that a bug, but... 

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
