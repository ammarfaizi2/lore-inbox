Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131227AbQKWKfR>; Thu, 23 Nov 2000 05:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131669AbQKWKfH>; Thu, 23 Nov 2000 05:35:07 -0500
Received: from 4dyn163.delft.casema.net ([195.96.105.163]:25867 "EHLO
        abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
        id <S131227AbQKWKex>; Thu, 23 Nov 2000 05:34:53 -0500
Message-Id: <200011231004.LAA06628@cave.bitwizard.nl>
Subject: Re: PROBLEM: Cruft mounting option incorrect in ISOFS code
In-Reply-To: <E13yi1u-0006V9-00@the-village.bc.nu> from Alan Cox at "Nov 22,
 2000 10:06:11 pm"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 23 Nov 2000 11:04:48 +0100 (MET)
CC: "Peel, Jeffery S" <jeffery.s.peel@intel.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > under 1 gig in size.  You can exhibit the problem by mounting the dvd movie
> > "The World is Not Enough" as it contains a video_ts.vob which is larger than
> > 1 gigabyte.  You will see that most of the file lengths are incorrect due to
> > the "cruft mounting option" hacking off the high order byte.  There are
> > certainly many more movies out there that exhibit this problem so it would
> > be a good thing for someone to fix.
 
> The cruft thing is correct in itself. The size being 4Gb is trivial
> to change providing someone can provide a reference to the standards
> that say its ok.  So is the limit 4Gig, who documents it ?

Page 137 of DVD Demystified by Jim Taylor says:

  - Individual files must be less than or equal to 1 gigabyte in length.

(i.e. I think the DVD is out of spec....)

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
