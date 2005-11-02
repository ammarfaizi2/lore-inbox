Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbVKBCs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbVKBCs3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 21:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbVKBCs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 21:48:29 -0500
Received: from host-84-9-201-132.bulldogdsl.com ([84.9.201.132]:24962 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S932229AbVKBCs3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 21:48:29 -0500
Date: Wed, 2 Nov 2005 02:47:55 +0000
From: Ben Dooks <ben@fluff.org.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: vojtech@suse.cz, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: best way to handle LEDs
Message-ID: <20051102024755.GA14148@home.fluff.org>
References: <20051101234459.GA443@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051101234459.GA443@elf.ucw.cz>
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2005 at 12:44:59AM +0100, Pavel Machek wrote:
> Hi!
> 
> Handheld machines have limited number of software-controlled status
> LEDs. Collie, for example has two of them; one is labeled "charge" and
> second is labeled "mail".
> 
> At least the "mail" led should be handled from userspace, and it would
> be nice if (at least) different speeds of blinking could be used --
> original Sharp ROM uses at least:
> 
> yellow off: 	not charging
> yellow on:	charging
> yellow fast blink: charge error
> 
> I think even slow blinking was used somewhere. I have some code from
> John Lenz (attached); it uses sysfs interface, exports led collor, and
> allows setting different frequencies.
> 
> Is that acceptable, or should some other interface be used?

there is already an LED interface for linux-arm, which is
used by a number of the extant machines in the sa11x0 and
pxa range.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
