Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129675AbQKORBV>; Wed, 15 Nov 2000 12:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129750AbQKORBM>; Wed, 15 Nov 2000 12:01:12 -0500
Received: from 13dyn206.delft.casema.net ([212.64.76.206]:64529 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S129675AbQKORBB>; Wed, 15 Nov 2000 12:01:01 -0500
Message-Id: <200011151630.RAA04141@cave.bitwizard.nl>
Subject: Re: 2.4. continues after Aieee...
In-Reply-To: <5.0.0.25.0.20001115111100.03572eb0@mail.etinc.com> from Dennis
 at "Nov 15, 2000 11:15:21 am"
To: Dennis <dennis@etinc.com>
Date: Wed, 15 Nov 2000 17:30:29 +0100 (MET)
CC: Rogier Wolff <R.E.Wolff@BitWizard.nl>, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dennis wrote:
> At 02:53 AM 11/15/2000, Rogier Wolff wrote:
> 
> >Shouldn't the system be "halted" after an "Aiee, killing interrupt
> >handler"?
> >
> 
> This brings another question. Has there been any work done to force linux 
> to reboot on all panics? Linux's propensity to crash drivers (say the 

You already have the option to say what happens on panic. 

> network card driver) and leave the system running make linux unusable in 
> unattended environments as the machine is functionally dead.

Which doesn't help in this case, as your network card COULD be dead,
while the system simply hasn't crashed....

				Roger.



-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
*       Common sense is the collection of                                *
******  prejudices acquired by age eighteen.   -- Albert Einstein ********
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
