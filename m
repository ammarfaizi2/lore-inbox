Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131397AbRBNHDO>; Wed, 14 Feb 2001 02:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131372AbRBNHDF>; Wed, 14 Feb 2001 02:03:05 -0500
Received: from femail1.rdc1.on.home.com ([24.2.9.88]:31723 "EHLO
	femail1.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S129032AbRBNHCz>; Wed, 14 Feb 2001 02:02:55 -0500
From: "C. D. Thompson-Walsh" <cdthompsonwalsh@home.com>
Reply-To: cdthompsonwalsh@home.com
Date: Wed, 14 Feb 2001 03:06:27 +0000
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="US-ASCII"
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.Linu.4.10.10102140711550.1209-100000@mikeg.weiden.de>
In-Reply-To: <Pine.Linu.4.10.10102140711550.1209-100000@mikeg.weiden.de>
Subject: Re: Problem: Floppy drive[?] hang
Organization: -
MIME-Version: 1.0
Message-Id: <01021403062700.00888@ariel>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 14, 2001 06:15 am, Mike Galbraith wrote:
> On Mon, 12 Feb 2001, C. D. Thompson-Walsh wrote:
> > [This sortof follows the format of the report form in REPORTING-BUGS]
> > 1. I've found a consistent set of circumstances which will hang 2.4.x
> > kernels on my system.
> >
> > 2. If the system is put under load to the point where it swaps heavily
> > (swapping appears to be pre-requisite, based on a little messing about),
> > and then given commands to use the floppy drive (mount, ls -- anything
> > which necessitates reading/writing to the floppy), it will hang with no
> > message (it does not OOPS, or at least it can not to the root console)
> > I've done this several times, with different disks and kernels, with and
> > without X.
>
> Hi,
>
> I tried to reproduce this on my PIII-500 VIA chipset box and couldn't.
> (problem doesn't seem to be generic fwiw)
>
> 	-Mike
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Hmm... Well, I haven't succeeded in hanging 2.2.x this way... So the 
hardware, (while likely flakey) works...

I'll try out another amd system of similar vintage (whose mb make I know! 
;-), and see if I can't find anything more helpful/generic... (as well as 
give speicifc mb info for this system, since it seems to be hw specific) I 
was going to put 2.4 on it anyways, eventually... In the meantime, well, who 
uses floppies, anyways? :-)

I really wish I knew enough about the kernel/fd and my c were good enough I 
could do something more constructive... I feel mildly guilty promising to do 
my best to expose someone else's bug... :-)

Best wishes,
C. D. Thompson-Walsh

