Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132737AbRD1OMJ>; Sat, 28 Apr 2001 10:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132786AbRD1OMA>; Sat, 28 Apr 2001 10:12:00 -0400
Received: from 13dyn184.delft.casema.net ([212.64.76.184]:51979 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S132737AbRD1OLv>; Sat, 28 Apr 2001 10:11:51 -0400
Message-Id: <200104281411.QAA04406@cave.bitwizard.nl>
Subject: Re: 2.4 and 2GB swap partition limit
In-Reply-To: <20010428093722.A17218@animx.eu.org> from Wakko Warner at "Apr 28,
 2001 09:37:22 am"
To: Wakko Warner <wakko@animx.eu.org>
Date: Sat, 28 Apr 2001 16:11:47 +0200 (MEST)
CC: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Xavier Bestel <xavier.bestel@free.fr>,
        Goswin Brederlow <goswin.brederlow@student.uni-tuebingen.de>,
        William T Wilson <fluffy@snurgle.org>, Matt_Domsch@Dell.com,
        linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wakko Warner wrote:
> > So you've spent almost $200 for RAM, and refuse to spend $4 for 1Gb of
> > swap space. Fine with me. 
 
> I put this much ram into the system to keep from having swap.  I
> still say swap=2x ram is a stupid idea.  I fail to see the logic in
> that.  Disk is much much slower than ram and if you're writing all
> ram to disk that's also slow.
 
> I have a machine with 256mb of ram and no disk.  It runs just fine
> w/o swap. Only reason I even had swap here is if I ran something
> that used up all my memory and it has happened.

> Since when has linux started to be like windows "our way or no way"?

I've ALWAYS said that it's a rule-of-thumb. This means that if you
have a good argument to do it differently, you should surely do so!

I maintain a 32M machine without swap. My workstation has 768Mb RAM
and almost 2G swap:

/home/wolff> free
             total       used       free     shared    buffers     cached
Mem:        770872     766724       4148          0     259816      78308
-/+ buffers/cache:     428600     342272
Swap:      1843212       1840    1841372
/home/wolff> 

That disk space is just sitting there. Never to be used. I spent $400
on the RAM, and I'm now reserving about $8 worth of disk space for
swap. I think that the $8 is well worth it. It keeps my machine
functional a while longer should something go haywire... As I said:
If you don't want to see it that way: Fine with me. 

				Roger. 



-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
