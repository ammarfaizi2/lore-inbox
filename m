Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133098AbRDVBA7>; Sat, 21 Apr 2001 21:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133100AbRDVBAt>; Sat, 21 Apr 2001 21:00:49 -0400
Received: from turnover.lancs.ac.uk ([148.88.17.220]:35836 "EHLO
	helium.chromatix.org.uk") by vger.kernel.org with ESMTP
	id <S133098AbRDVBAh>; Sat, 21 Apr 2001 21:00:37 -0400
Message-Id: <l03130310b707dc53131a@[192.168.239.105]>
In-Reply-To: <200104220033.f3M0XsM162528@saturn.cs.uml.edu>
In-Reply-To: <Pine.LNX.4.32.0104211456540.4237-100000@filesrv1.baby-dragons.com> from
 "Mr. James W. Laferriere" at Apr 21, 2001 02:59:46 PM
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 22 Apr 2001 02:00:02 +0100
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        babydr@baby-dragons.com (Mr. James W. Laferriere)
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: Request for comment -- a better attribution system
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), esr@thyrsus.com,
        linux-kernel@vger.kernel.org (CML2),
        kbuild-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 	Find . -name "*Some-Name*" -type f -print | xargs grep 'Some-Info'
>> 	Hate answering with just one line of credible info , But .
>
>The above would grep every file. It takes 1 minute and 9.5 seconds.
>So the distributed maintainer information does not scale well at all.

No it doesn't.  It allows you to search for files of a specific naming
pattern and greps those.  So if you needed to know the maintainers of all
the config.in files, you say:

find . -name "*onfig.in" -type f -print | xargs grep 'P: '

If you need to know the maintainer(s) of a specific file or directory of
files, simply direct your search there.  The only problem occurs when you
really don't know where to look - so then you search the entire kernel for
the configuration option, and look wherever you find that.

I really don't see the problem.

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


