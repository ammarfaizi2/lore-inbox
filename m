Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131305AbRC0ONx>; Tue, 27 Mar 2001 09:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131308AbRC0ONn>; Tue, 27 Mar 2001 09:13:43 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:40929 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S131305AbRC0ONj>; Tue, 27 Mar 2001 09:13:39 -0500
Message-Id: <l03130335b6e64c775376@[192.168.239.101]>
In-Reply-To: <3AC09480.E8317507@evision-ventures.com>
In-Reply-To: <l03130332b6e632432b9f@[192.168.239.101]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 27 Mar 2001 14:57:52 +0100
To: Martin Dalecki <dalecki@evision-ventures.com>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: OOM killer???
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Plase change to 100 to 500 - this would make it consistant with
>the useradd command, which starts adding new users at the UID 500

Depends on which distribution you're using.  In my experience, almost all
the really important stuff happens below 100.  In any case, the
OOM-kill-selection algorithm in this patch is *not* final.  See my
accompanying mail.

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


