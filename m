Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbVLNMbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbVLNMbT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 07:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbVLNMbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 07:31:18 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:32429
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932431AbVLNMbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 07:31:18 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: ipw2200 [was Re: RFC: Starting a stable kernel series off the 2.6 kernel]
Date: Wed, 14 Dec 2005 06:26:08 -0600
User-Agent: KMail/1.8
Cc: Bill Davidsen <davidsen@tmr.com>, Mark Lord <lkml@rtr.ca>,
       Adrian Bunk <bunk@stusta.de>, David Ranson <david@unsolicited.net>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Matthias Andree <matthias.andree@gmx.de>
References: <20051203135608.GJ31395@stusta.de> <200512110312.47142.rob@landley.net> <20051212114952.GB6533@elf.ucw.cz>
In-Reply-To: <20051212114952.GB6533@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512140626.08583.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 December 2005 05:49, Pavel Machek wrote:
> > Or I could move initramfs extraction earlier in the boot sequence and
> > never have to modify any _other_ drivers that want firmware in order to
> > be able to make them work too, rather than playing whack-a-mole teaching
> > drivers I don't care about how to hold off on wanting firmware.
>
> Except that whack-a-mole is a right thing to do here, and that
> initramfs movement is unlikely to make it into mainline.
>        Pavel

Let me guess: for licensing reasons?

The option to keep initramfs in a separate file (like initrd) should, in 
theory, make that a moot point...

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.
