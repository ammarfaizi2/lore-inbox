Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbWCMWts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbWCMWts (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 17:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbWCMWts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 17:49:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60059 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964828AbWCMWtr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 17:49:47 -0500
Date: Mon, 13 Mar 2006 14:42:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>,
       Parag Warudkar <kernel-stuff@comcast.net>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       "Bob Copeland" <bcopeland@gmail.com>,
       Paul Fulghum <paulkf@microgate.com>, stegall@bayou.uni-linz.ac.at,
       Matthew Grant <grantma@anathoth.gen.nz>,
       "Miguel Blanco" <mblancom@gmail.com>,
       Frithjof Kruggel <fkruggel@uci.edu>, <gaa@mail.nnov.ru>,
       "Mauro Tassinari" <mtassinari@cmanet.it>,
       "Ian E. Morgan" <imorgan@webcon.ca>
Subject: Re: 2.6.16-rc6: known regressions
Message-Id: <20060313144244.266d96ef.akpm@osdl.org>
In-Reply-To: <20060313200544.GG13973@stusta.de>
References: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org>
	<20060313200544.GG13973@stusta.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> This email lists some known regressions in 2.6.16-rc6 compared to 2.6.15.
>

We've also left a trail of wrecked machines behind us from earlier kernels.


Post-2.6.12:
  From: Kyle Moffett <mrmacman_g4@mac.com>
  Subject: [2.6.15] PDC202XX error: "no DRQ after issuing MULTWRITE_EXT"

Post-2.6.15:
  From: Parag Warudkar <kernel-stuff@comcast.net>
  Subject: Re: ALSA HDA Intel stoped to work in 2.6.16-*

Post-<not sure, looks recent>
  From: Jeremy Fitzhardinge <jeremy@goop.org>
  Subject: 2.6.15-1.2032_FC5 (2.6.16rc5-git9?): Losing ticks with x86_64 w/ Nvidia chipset

Post-<tty changes, perhaps>
  From: "Bob Copeland" <bcopeland@gmail.com>
  Subject: 2.6.16-rc5 pppd oops on disconnects

<recent oopses in exit_mmap>:
  From: stegall@bayou.uni-linz.ac.at
  Subject: amd64  -- recent kernels

  (err, private email - not sure if this has made it to a mailing list yet?)

XFS-related oopses:
  http://bugzilla.kernel.org/show_bug.cgi?id=6180

Post-<probably pselect/ppoll changes>:
  From: Matthew Grant <grantma@anathoth.gen.nz>
  Subject: PROBLEM:  rt_sigsuspend() does not return EINTR on 2.6.16-rc2+

Post-2.6.14:
  From: "Miguel Blanco" <mblancom@gmail.com>
  Subject: problem mounting a jffs2 filesystem

  (We might have fixed this?)

Post-2.6.13:
  From: Frithjof Kruggel <fkruggel@uci.edu>
  Subject: aic79xx + tape 2.6.13.5 -> 2.6.15.4 problem

Post-2.6.14:
  From: <gaa@mail.nnov.ru>
  Subject: PROBLEM: "rmmod snd_cmipci" cause an Oops

Post-2.6.16-rc1:
  From: "Mauro Tassinari" <mtassinari@cmanet.it>
  Subject: Re: 2.6.16-rc3: more regressions

  (Radeon makes Xorg hang)

Post-<didn't say>
  From: "Ian E. Morgan" <imorgan@webcon.ca>
  Subject: Process D-stated in generic_unplug_device


That's maybe a quickie quarter of what I have here - it takes quite some
time and email to sift through these things..
