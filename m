Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269685AbTGZUtJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 16:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269672AbTGZUtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 16:49:08 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:8079 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S269685AbTGZUsQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 16:48:16 -0400
Date: Sat, 26 Jul 2003 23:03:19 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp updates
Message-ID: <20030726210318.GE266@elf.ucw.cz>
References: <20030726204528.GA350@elf.ucw.cz> <Pine.LNX.4.44.0307261403390.23977-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307261403390.23977-100000@cherise>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This updates swsusp: CONFIG_SOFTWARE_SUSPEND and CONFIG_ACPI_SLEEP are
> > separated (it was getting users *badly* confused), remove too noisy
> > printk's, correctly restore console after S3, fixes suspend on
> > machines using yenta_socket.c, fixes some comments, cleans up
> > "interesting" macro mess in suspend.c, no longer eats filesystems when
> > process is ^Z-ed before suspend. Please apply,
> 
> Could you please split these patches up into different functional patches, 
> and submit them to the appropriate maintainers? 

SOFTWARE SUSPEND:
P:      Pavel Machek
M:      pavel@suse.cz
M:      pavel@ucw.cz
L:      http://lister.fornax.hu/mailman/listinfo/swsusp
W:      http://swsusp.sf.net/
S:      Maintained

Other parts are trivial (ACPI and yenta), and pretty obvious.
									Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
