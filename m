Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbTJAKNg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 06:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbTJAKNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 06:13:36 -0400
Received: from gprs146-6.eurotel.cz ([160.218.146.6]:30592 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261625AbTJAKNf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 06:13:35 -0400
Date: Wed, 1 Oct 2003 12:09:29 +0200
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Nicolas Mailhot <Nicolas.Mailhot@laposte.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Keyboard oddness.
Message-ID: <20031001100929.GB398@elf.ucw.cz>
References: <1064569422.21735.11.camel@ulysse.olympe.o2t> <20030926102403.GA8864@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030926102403.GA8864@ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Of course this won't fix any problems with USB, if there are still any.
> My USB keyboard works just perfectly, no problems with the autorepeat.

Can you try running your system with interrupts disabled for 100ms+
sometimes? That should show any bugs/races in keyboard code. Perhaps
you have good hardware that never ever disables interrupts for that
long, but other people have more broken stuff.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
