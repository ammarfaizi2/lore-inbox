Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270833AbTG0QDe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 12:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270845AbTG0QDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 12:03:34 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:6089 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S270833AbTG0QDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 12:03:32 -0400
Date: Sun, 27 Jul 2003 18:18:12 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: "David D. Hagood" <wowbagger@sktc.net>
Cc: "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: time for some drivers to be removed?
Message-ID: <20030727161812.GQ22218@fs.tum.de>
References: <Pine.LNX.4.53.0307240817520.19533@localhost.localdomain> <20030727153118.GP22218@fs.tum.de> <3F23F6EB.7070502@sktc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F23F6EB.7070502@sktc.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 27, 2003 at 10:59:39AM -0500, David D. Hagood wrote:
>...
> An item with a BROKEN flag would NOT be built in an ALLYES or ALLMODULE 
> configuration - it would require the user to explicitly enable the item 
> in the configuration, and the user would be notified that the module in 
> question was not compiling/linking the last time the configuration data 
> was updated by the kernel team.
>...

I tend to disagree.

IMHO every selectable configuration should result in a kernel that 
compiles. Yes, it's neaarly impossible to achieve this 100%, but at 
least on i386 we are in 2.4 near to it for all not-very-obscure 
configurations.

Where's the win if you are able to select an option that doesn't 
compile? This will only cause confusion for people who compile more into 
the kernel than needed (but it does no harm).

Don't forget: The vast majorit of people compiling the kernel don't know 
anything about the internals of the kernel.

If you _really_ want to see the cmpile errors it's easy to edit the 
Kconfig file.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

