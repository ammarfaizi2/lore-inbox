Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270894AbTGPK0i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 06:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270895AbTGPK0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 06:26:38 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:4253 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S270894AbTGPKZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 06:25:49 -0400
Date: Wed, 16 Jul 2003 12:40:26 +0200
From: Pavel Machek <pavel@suse.cz>
To: root@mauve.demon.co.uk
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Suspend on one machine, resume elsewhere [was Re: [Swsusp-devel] RE:Re: Thoughts wanted on merging Softwa]
Message-ID: <20030716104026.GC138@elf.ucw.cz>
References: <20030716083758.GA246@elf.ucw.cz> <200307161037.LAA01628@mauve.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307161037.LAA01628@mauve.demon.co.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Anyway, depending on acpi is wrong and needs to be fixed in 2.7.
> > > 
> > > Could you elaborate on that? Do you mean S4, or any suspend state in
> > > general?
> > 
> > It would be nice to have arch-neutral way to enter suspend to ram and
> > suspend to disk. Being arch-neutral, it may not depend on ACPI.
> 
> Taking this in a slightly different direction.
> 
> It would be even nicer to be able to be able to migrate machine images
> between machines.
> How identical do machines have to be before it's no longer just a case
> of copying the file?
> Identical make of RAM, same CPU model, same BIOS version, with the PCI and 
> USB things connected to the same slots in the same way?
> Or is it a little looser?

Well, for USB maybe hotplug would handle the change, all the other
stuff should better be the same.

It probably will work even with (for example) slightly different BIOS
version, but... don't count on that.

If you want to migrate programs between machines, run UMLinux, same
config, on both machines. Ouch and you'll need swsusp for UMLinux, too
;-).
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
