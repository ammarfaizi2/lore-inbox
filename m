Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131479AbRC0SjS>; Tue, 27 Mar 2001 13:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131482AbRC0SjI>; Tue, 27 Mar 2001 13:39:08 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:42991 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S131479AbRC0SjD>; Tue, 27 Mar 2001 13:39:03 -0500
Message-Id: <l0313033bb6e68d4f8fbb@[192.168.239.101]>
In-Reply-To: <20010327200830.C8133@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <3AC09480.E8317507@evision-ventures.com>; from
 dalecki@evision-ventures.com on Tue, Mar 27, 2001 at 03:24:16PM +0200
 <l03130332b6e632432b9f@[192.168.239.101]>
 <3AC09480.E8317507@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 27 Mar 2001 19:37:32 +0100
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Martin Dalecki <dalecki@evision-ventures.com>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: OOM killer???
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>If we use my OOM killer API, this patch would be a module and
>could have module parameters to select that.
>
>Johnathan: I URGE you to apply my patch before adding OOM killer
>   stuff. What's wrong with it, that you cannot use it? ;-)
>
>It is easy to add configurables to a module and play with them
>WITHOUT recompiling.

Thanks for reminding me - I'll look into it on the plane and see what I can
do with it.

>e.g. My important matlab calculation, which runs in user mode
>should not be killed. But killing a local webserver, which serves
>my help system is ok (because I will not loose work, and might
>get it over the net, if there is a problem).
>
>So as Rik stated: The OOM killer cannot suit all people, so it
>has to be configurable, to be OOM kill, not overkill ;-)

Yes, configurability is probably a very good idea.  However, it would be
best to include a good set of general parameters in the kernel itself, so
the set of average systems needs as little tweaking as possible.  One
cannot expect every sysadmin to be familiar with these arcane (and rarely
actually used) parameters, so being able to select "server", "batch",
"workstation", "embedded" and so on would help massively.

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
-----END GEEK CODE BLOCK-----


