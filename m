Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130448AbRCCLO4>; Sat, 3 Mar 2001 06:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130449AbRCCLOh>; Sat, 3 Mar 2001 06:14:37 -0500
Received: from 13dyn216.delft.casema.net ([212.64.76.216]:49929 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S130448AbRCCLO2>; Sat, 3 Mar 2001 06:14:28 -0500
Message-Id: <200103031114.MAA13672@cave.bitwizard.nl>
Subject: Re: 2.4 and 2GB swap partition limit
In-Reply-To: <Pine.LNX.4.21.0103030113520.17415-100000@benatar.snurgle.org> from
 William T Wilson at "Mar 3, 2001 01:14:28 am"
To: William T Wilson <fluffy@snurgle.org>
Date: Sat, 3 Mar 2001 12:14:22 +0100 (MET)
CC: Matt_Domsch@Dell.com, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William T Wilson wrote:
> On Fri, 2 Mar 2001 Matt_Domsch@Dell.com wrote:
> 
> > Linus has spoken, and 2.4.x now requires swap = 2x RAM.
> 
> I think I missed this.  What possible value does this have?  (Not even
> Sun, the original purveyors of the 2x RAM rule, need this any more).

RAM is still about 100x more expensive than HD. So I always recommend
you use about 2% of the money you spent on RAM to pay for the HD space
to handle swap.

Actually the deal is: either use enough swap (about 2x RAM) or use
none at all. 

A "good" operating system will want to use say half your memory for
buffers, even if there are processes using that half of your RAM. Not
when they are actively using it, but only after they have NOT used it
for say an hour. Then the users of the machine will see efficient use
of the resources. It does have the disadvantage that when you come back 
in the morning, your xterm may have been swapped out because of the
nightly backups and stuff....

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
