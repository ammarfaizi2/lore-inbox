Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131633AbQKRKzG>; Sat, 18 Nov 2000 05:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131647AbQKRKy4>; Sat, 18 Nov 2000 05:54:56 -0500
Received: from 13dyn189.delft.casema.net ([212.64.76.189]:25863 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S131633AbQKRKyp>; Sat, 18 Nov 2000 05:54:45 -0500
Message-Id: <200011181024.LAA12946@cave.bitwizard.nl>
Subject: Re: RFC: "SubmittingPatches" text
In-Reply-To: <20001117163716.A29847@veritas.com> from Andries Brouwer at "Nov
 17, 2000 04:37:16 pm"
To: Andries Brouwer <aeb@veritas.com>
Date: Sat, 18 Nov 2000 11:24:39 +0100 (MET)
CC: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>,
        linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> On Fri, Nov 17, 2000 at 09:30:13AM +0100, Kai Germaschewski wrote:
> 
> > One question comes to my mind: Are patches supposed to be applied with
> > patch -p0 or patch -p1? 
> 
> Suppose the kernel tree is in /kernpath, starting with /kernpath/linux.
> Linus' patches can be applied by (cd /kernpath; patch -p0 -s < patch)
                   ^^^^ ALSO
> while Alan's patches only work if you do
> (cd /kernpath/linux; patch -p1 -s < ../patch)

For uniformity, I would recommend that everyone generates patches that 
are "Linus-style", but that when applying, you treat them as "Alan-style". 

Less chances for surprises.

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
