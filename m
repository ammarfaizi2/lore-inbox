Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265553AbTF2EYf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 00:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265554AbTF2EYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 00:24:35 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:56198 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S265553AbTF2EYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 00:24:34 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Johan Braennlund <spahmtrahp@yahoo.com>
Date: Sun, 29 Jun 2003 14:38:14 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16126.27958.725918.962536@gargle.gargle.HOWL>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH - ALPS glidepoint/dualpoint driver for 2.5.7x
In-Reply-To: message from Johan Braennlund on Sunday June 29
References: <Pine.LNX.4.53.0306290122250.25086@h192n1fls22o1048.telia.com>
X-Mailer: VM 7.16 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday June 29, spahmtrahp@yahoo.com wrote:
> 
> Hi! Thank you for the patch. It looks interesting, but unfortunately it
> doesn't work very well for me. I have an Acer Aspire laptop with a
> four-button Alps touchpad (left,right and two up/down scroll buttons). The
> "down" button functions as the middle mouse button, but I've never been
> able to get the "up" button properly recognized under linux.
> 
> If I apply your patch to 2.5.73, none of the buttons work (except for
> tapping for left-click), neither in X nor with gpm, but touchpad movement
> works fine, with increased sensitivity compared to the standard driver.
> Unpatched 2.5.73 works as expected.

Hmmm... the joys of no documentation....

Can you
  grab  http://www.cse.unsw.edu.au/~neilb/D800/mouseplay.c
  compile it
  boot into a 2.4 kernel
  Disable gpm and get out of X
  run mouseplay capturing the output 
    e.g. mouseplay | tee /tmp/m.out
  perform various mouse action, particularly the buttons
  annotate /tmp/m.out to tell me what you did when,
  send m.out to me.

Thanks,
NeilBrown

 
