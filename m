Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130985AbRBTXS1>; Tue, 20 Feb 2001 18:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130999AbRBTXSR>; Tue, 20 Feb 2001 18:18:17 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:56965 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S130985AbRBTXSM>; Tue, 20 Feb 2001 18:18:12 -0500
Message-Id: <l03130359b6b8a6115936@[192.168.239.101]>
In-Reply-To: <3A92F17E.BFEDEADD@sympatico.ca>
In-Reply-To: <01022020011905.18944@gimli>
 <96uijf$uer$1@penguin.transmeta.com> <3A92DCE0.BEE5E90E@sympatico.ca>
 <3A92DF84.E39E415C@windsormachine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 20 Feb 2001 22:58:36 +0000
To: Jeremy Jackson <jeremy.jackson@sympatico.ca>,
        Mike Dresser <mdresser@windsormachine.com>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: [rfc] Near-constant time directory index for Ext2
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Perhaps rm -rf . would be faster?  Let rm do glob expansion,
>without the sort.  Care to recreate those 65535 files and try it?

Perhaps, but I think that form is still fairly slow.  It takes an
"uncomfortable" amount of time to remove a complex directory structure
using, eg. "rm -rf /usr/src/linux-obsolete" or "rm -rf
downloads/XFree86-old-and-buggy".  I'm not sure, but I would guess it's not
as much quicker than removing each file individually as you might think.

If I had more time on my hands, I'd run some quick benchmarks on some of my
systems.

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
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r- y+
-----END GEEK CODE BLOCK-----


