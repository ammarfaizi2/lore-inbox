Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131476AbRCNR3i>; Wed, 14 Mar 2001 12:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131478AbRCNR32>; Wed, 14 Mar 2001 12:29:28 -0500
Received: from imladris.infradead.org ([194.205.184.45]:31245 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S131476AbRCNR3G>;
	Wed, 14 Mar 2001 12:29:06 -0500
Date: Wed, 14 Mar 2001 17:28:05 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.CX>
To: <Andries.Brouwer@cwi.nl>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, <seberino@spawar.navy.mil>
Subject: Re: [PATCH] Improved version reporting
In-Reply-To: <UTC200103141601.RAA189084.aeb@vlet.cwi.nl>
Message-ID: <Pine.LNX.4.30.0103141718380.6366-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andries.

 >> -o  util-linux             2.10o                   # fdformat --version
 >> +o  util-linux         #   2.10o        # fdformat --version

 > Looking at fdformat to get the util-linux version is perhaps not
 > the most reliable way - some people have fdformat from fd-utils
 > or so.

{Shrug} That's the command that was in both Documentation/Changes and
in scripts/ver_linux and I just left what was already there, as shown
by your quote. Somebody MUCH more knowledgable than me regarding
kernel requirements can sort that out.

 > Using mount --version would be better - I am not aware of any
 > other mount distribution.

RedHat distribute mount separately from util-linux and I wouldnae be
surprised if others do the same...

 >> +In addition, it is wise to ensure that the following packages are at least
 >> +at the versions suggested below, although these may not be required,
 >> +depending on the exact configuration of your system:
 >> +
 >> +o  Console Tools      #   0.3.3        # loadkeys -V
 >> +o  Mount              #   2.10e        # mount --version

 > Concerning mount:
 >
 > (i) the version mentioned is too old,

Probably. As stated, that's what's currently installed here, and I
havenae the foggiest whether any of them need upgrading as there's
nothing I've been able to find to say what the minimum version is.

 > (ii) mount is in util-linux.

Not on RedHat systems.

 > Conclusion: the mount line should be deleted entirely.

Maybe, but that's not for me to decide. Whoever wrote ver_linux
obviously thought it important.

 > Concerning Console Tools: maybe kbd-1.05 is uniformly better.
 > I am not aware of any reason to recommend the use of console-tools.

Neither am I. The ver_linux script has lines for determining the
versions for both Console Tools and Kbd but on EVERY system I've
tried, including Slackware, RedHat, Debian, Caldera, and SuSE based
ones, the line for determining Kbd versiondoesnae work. I've just
included the line that worked, and ignored the Kbd one as I can see no
point including something that doesnae work.

Best wishes from Riley.

