Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131502AbRCNTbR>; Wed, 14 Mar 2001 14:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131503AbRCNTbI>; Wed, 14 Mar 2001 14:31:08 -0500
Received: from hera.cwi.nl ([192.16.191.8]:57752 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S131502AbRCNTa6>;
	Wed, 14 Mar 2001 14:30:58 -0500
Date: Wed, 14 Mar 2001 20:29:53 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200103141929.UAA178418.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, rhw@MemAlpha.CX
Subject: Re: [PATCH] Improved version reporting
Cc: kaboom@gatech.edu, linux-kernel@vger.kernel.org, seberino@spawar.navy.mil
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Riley Williams <rhw@MemAlpha.CX>

[Yes, I wrote, replying to your mail, just because I happened
to notice the incorrect or debatable lines in your patch.
Let me cc the Changes maintainer - maybe Chris Ricker.]

     >> -o  util-linux             2.10o                   # fdformat --version
     >> +o  util-linux         #   2.10o        # fdformat --version

     > Looking at fdformat to get the util-linux version is perhaps not
     > the most reliable way - some people have fdformat from elsewhere.
     > Using mount --version would be better - I am not aware of any
     > other mount distribution.

    RedHat distribute mount separately from util-linux and I wouldnae be
    surprised if others do the same...

I am not aware of any distribution that ships some version of
util-linux, but replaces its mount part by an older version.
I think that even in cases where, because of historical reasons, util-linux
is repackaged in several parts, mount --version gives the right answer.

     >> +In addition, it is wise to ensure that the following packages are
     >> +at least at the versions suggested below, although these may not
     >> +be required, depending on the exact configuration of your system:
     >> +
     >> +o  Console Tools      #   0.3.3        # loadkeys -V
     >> +o  Mount              #   2.10e        # mount --version

     > Concerning mount:
     >
     > (i) the version mentioned is too old,
     > (ii) mount is in util-linux.

    Not on RedHat systems.

There is no other source. Some people like to repack but that
has no influence on versions.

     > Conclusion: the mount line should be deleted entirely.
     > Concerning Console Tools: maybe kbd-1.05 is uniformly better.
     > I am not aware of any reason to recommend the use of console-tools.

    Neither am I. The ver_linux script has lines for determining the
    versions for both Console Tools and Kbd but on EVERY system I've
    tried, including Slackware, RedHat, Debian, Caldera, and SuSE based
    ones, the line for determining Kbd versiondoesnae work. I've just
    included the line that worked, and ignored the Kbd one as I can see no
    point including something that doesnae work.

You are mistaken, as is proved by the reports that contain a kbd line:
a grep on linux-kernel for this Februari shows people with
Kbd 0.96, 0.99 and 1.02.


Andries

