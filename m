Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272554AbTG1BHb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 21:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272548AbTG1ADi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:03:38 -0400
Received: from zeus.kernel.org ([204.152.189.113]:31477 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272738AbTG0W6p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 18:58:45 -0400
Date: Sun, 27 Jul 2003 22:56:39 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "David D. Hagood" <wowbagger@sktc.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: time for some drivers to be removed?
Message-ID: <20030727205638.GD22218@fs.tum.de>
References: <Pine.LNX.4.53.0307240817520.19533@localhost.localdomain> <20030727153118.GP22218@fs.tum.de> <3F23F6EB.7070502@sktc.net> <1059324018.13442.0.camel@dhcp22.swansea.linux.org.uk> <3F241DC0.7080408@sktc.net> <1059338443.13875.2.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059338443.13875.2.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 27, 2003 at 09:40:43PM +0100, Alan Cox wrote:
> On Sul, 2003-07-27 at 19:45, David D. Hagood wrote:
> > I would disagree - OBSOLETE to me means just that - that module is 
> > obsolete. Minix FS, OSS (as opposed to ALSA), and the old non-SCSI, 
> > non-IDE HD interfaces would be OBSOLETE.
> > 
> > Besides, I have seen cases where Firewire modules wouldn't build for 
> > some period of time - would you deem them OBSOLETE?
> 
> The code in question is obsolete if it wont build because its out of date
> with respect to the core. The point I was trying to make is we have a
> definition (have had since 2.2) and actively use it. So there is nothing
> to invent here

That's no problem for me.

The only question is how to call the option that allows building only on
UP (e.g. cli/sti usage in the driver)? My suggestion was BROKEN_ON_SMP,
would you suggest OBSOLETE_ON_SMP?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

