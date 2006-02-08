Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932489AbWBHTdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbWBHTdG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 14:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbWBHTdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 14:33:06 -0500
Received: from fmr21.intel.com ([143.183.121.13]:31936 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S932489AbWBHTdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 14:33:03 -0500
Date: Wed, 8 Feb 2006 11:32:02 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Linda Walsh <lkml@tlinx.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: File "Changelog-2.6.15": missing signoffs
Message-ID: <20060208193202.GA8275@agluck-lia64.sc.intel.com>
References: <43E935BA.8050605@tlinx.org> <43E943FD.7090508@tlinx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E943FD.7090508@tlinx.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 05:06:05PM -0800, Linda Walsh wrote:
> Actually, ("talking" to myself?), parsing this file a bit more,
> I find many (~134) that are missing "Sign-offs".
> 
> I take it that "Sign-off"s are also "optional" on commits
> and represent that the author specified under the "commit"
> tag did not need a "Sign-off"?
> 
> Just trying to see if I can parse large changelogs into groups
> that might be easier digest and summarize...

I make the count 121 (but instead of taking the Changelog I started
from the output of "git whatchanged v2.6.15 ^v2.6.14").  This was from
a total of 4959 commits, so we are scoring at 97.5%.  Most of them do
appear to be an author not signing off on his own work when working in
their own git tree.  Jeff Garzik seems to be an expert at this with 70
commits where he is listed as Author, but there is no signed-off-by line.
Linus is in second place with 8, but most of those were simply changing
the release in the Makefile for each "-rcN".  The 2 that weren't were
Linus fixing a silly typo and reverting a previous commit, perhaps these
were deliberately not signed?  Then there is a long tail.  Here's the full
list with the abbreviated commit SHA1 as reported by git whatchanged.
Use "git show 000404f" (from a recent version of git) to see the commit
& diff.

Author: Adrian Bunk <bunk@stusta.de>
 000404f... (from dc6f3f2...)
 dc6f3f2... (from f093182...)
Author: Alan Cox <alan@lxorguk.ukuu.org.uk>
 11e29e2... (from 307e4dc...)
 47a8659... (from fe998aa...)
 9119075... (from ccd7bc2...)
Author: Albert Lee <albertcc@tw.ibm.com>
 3aef523... (from c187c4b...)
 9d5b130... (from 3aef523...)
 c187c4b... (from 47a8659...)
Author: Andrew Morton <akpm@osdl.org>
 89358f9... (from 48257c4...)
Author: Ayaz Abdulla <aabdulla@nvidia.com>
 ac9c189... (from 9789089...)
Author: Christoph Hellwig <hch@lst.de>
 e330562... (from c2a8fad...)
Author: Dave Airlie <airlied@starflyer.(none)>
 5fb4dc9... (from 23bfc1a...)
Author: James Ketrenos <jketreno@linux.intel.com>
 519a62b... (from d3f7bf4...)
 af9288a... (from 6eb6edf...)
 cf1b479... (from 8171537...)
 d7e02ed... (from e189277...)
Author: Jaroslav Kysela <perex@suse.cz>
 b00e844... (from 63786d0...)
Author: Jeff Garzik <jgarzik@pobox.com>
 005a5a0... (from e533825...)
 0169e28... (from be15cd7...)
 02eaa66... (from 828d09d...)
 057ace5... (from cf48293...)
 07c1da2... (from 00ac37f...)
 095fec8... (from 02eaa66...)
 0e5dec4... (from 54dac83...)
 0f0d519... (from a7dac44...)
 101ffae... (from 522479f...)
 193515d... (from 0b154bb...)
 2237467... (from 64f043d...)
 2759c8d... (from e2e9650...)
 2917953... (from f85272a...)
 2a47ce0... (from 101ffae...)
 2c13b7c... (from e1410f2...)
 2d5a2ae... (from 63172cb...)
 3b7d697... (from f51750d...)
 3f19ee8... (from 644dd0c...)
 422fa08... (from ffe75ef...)
 47c2b67... (from ba3fe8f...)
 5063019... (from be0d9b6...)
 50eb800... (from ecf8b59...)
 522479f... (from 47c2b67...)
 6037d6b... (from c2cc87c...)
 6248e64... (from 0f0d519...)
 644dd0c... (from 87e807b...)
 64f043d... (from 556c66d...)
 67846b3... (from 643736a...)
 68399bb... (from edea3ab...)
 7bbaa75... (from 2d5a2ae...)
 7bdd720... (from c2cd76f...)
 828d09d... (from cd52d1e...)
 8a70f8d... (from 05b308e...)
 8b26024... (from 095fec8...)
 8cee0cd... (from bb40dcb...)
 972c26b... (from b194b42...)
 98684a9... (from be0d9b6...)
 9a68c1b... (from 8b26024...)
 9f68a24... (from c6e6e66...)
 a10b5aa... (from 4aefe15...)
 a121349... (from bfd0072...)
 a15dbeb... (from 67846b3...)
 a21a84a... (from 96b88fb...)
 a2c91a8... (from 2237467...)
 a7dac44... (from 81cfb88...)
 a939c96... (from a15dbeb...)
 a9524a7... (from fbf30fb...)
 ac19bff... (from 9dfb780...)
 ad36d1a... (from 4ba529a...)
 b095518... (from 88d7bd8...)
 b2795f5... (from 2468297...)
 ba3fe8f... (from bca1c4e...)
 bca1c4e... (from 9a68c1b...)
 be2b28e... (from a7990ba...)
 c2a8fad... (from eedb9f0...)
 c2cd76f... (from 75b1f2f...)
 c6e6e66... (from 2c13b7c...)
 c9d3913... (from 2a47ce0...)
 cedc9a4... (from ed39f73...)
 cf48293... (from 452503f...)
 e12669e... (from 8a70f8d...)
 e1410f2... (from ad36d1a...)
 e2b1be5... (from c0ab424...)
 e2e9650... (from 596ff2e...)
 e533825... (from 6e9d6b8...)
 ea182d4... (from ab80882...)
 ecf8b59... (from a10b5aa...)
 f7492f1... (from 51c83a9...)
 fbf30fb... (from 6248e64...)
Author: Jeff Garzik <jgarzik@pretzel.yyz.us>
 0274aa2... (from 80bd6d7...)
Author: Jeff Raubitschek <jhr@google.com>
 54dac83... (from 2ee73cc...)
Author: Jesper Juhl <jesper.juhl@gmail.com>
 b4558ea... (from 7380a78...)
Author:  <jketreno@io.(none)>
 25b645b... (from 8232835...)
Author: John Linville <linville@tuxdriver.com>
 6c1792f... (from dbc2309...)
Author: Komuro <komurojun-mbn@nifty.com>
 ab80882... (from 1d97f38...)
Author: Kyungmin Park <kyungmin.park@samsung.com>
 20ba89a... (from 37b1cc3...)
Author: Ladislav Michl <ladis@linux-mips.org>
 a637a11... (from a06d61c...)
Author: Linus Torvalds <torvalds@g5.osdl.org>
 0fde7f5... (from 3beb207...)
 1224b37... (from 8e31108...)
 3bedff1... (from 4477914...)
 5666c09... (from d2149b5...)
 624f54b... (from 5d24091...)
 8802684... (from 8f493d7...)
 cd52d1e... (from 508862e...)
 f89f594... (from 01e33b5...)
Author: Mark Lord <liml@rtr.ca>
 edea3ab... (from 3d3467f...)
 dcc2d1e... (from e12a1be...)
Author: Mateusz Berezecki <mateuszb@gmail.com>
 e260836... (from 075897c...)
Author: Michal Wronski <Michal.Wronski@motorola.com>
 65163fd... (from 6dfca87...)
Author: Pantelis Antoniou <pantelis.antoniou@gmail.com>
 48257c4... (from d8840ac...)
Author: Paul Mackerras <paulus@samba.org>
 a21ead3... (from df0d3ce...)
Author: Ralf Baechle <ralf@linux-mips.org>
 15b96a4... (from 307bd28...)
 2862279... (from 15b96a4...)
Author: Russell King <rmk+kernel@arm.linux.org.uk>
 866237e... (from e399822...)
 d56c524... (from 866237e...)
 e399822... (from 30c2f90...)
Author: Steve French <sfrench@us.ibm.com>
 190fdeb... (from 0ae0efa...)
 7b7abfe... (from e82b3ae...)
Author: Tejun Heo <htejun@gmail.com>
 537a95d... (from fecb4a0...)
Author: Thomas Gleixner <tglx@linutronix.de>
 03ead84... (from 182ec4e...)
 f0250fd... (from 01ac742...)
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
 6fa05b1... (from ab27642...)
 f134585... (from 3063d8a...)
Author: Zhu Yi <chuyee@debian.sh.intel.com>
 a1e695a... (from ee8e365...)
