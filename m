Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbTFZRg1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 13:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbTFZRg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 13:36:27 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:33993 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262179AbTFZRgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 13:36:25 -0400
Date: Thu, 26 Jun 2003 19:50:32 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Jan-Hinnerk Reichert <jan-hinnerk_reichert@hamburg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.22-pre1] menuconfig oddity
Message-ID: <20030626175032.GA24661@fs.tum.de>
References: <200306231927.57946.jan-hinnerk_reichert@hamburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306231927.57946.jan-hinnerk_reichert@hamburg.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 23, 2003 at 07:27:57PM +0200, Jan-Hinnerk Reichert wrote:
> Hi,
> 
> first I want to say that I could compile 2.4.22-pre1 without problems and 
> everything works fine for 4 hours on a desktop machine with little load.
> 
> However, I had a small problem during my installation:
> 
> After the first compilation and reboot, I started menuconfig again and all 
> subentries of "ACPI support" were gone. I took a brief look at the .config, 
> but there were at least some entries.
> 
> So I ignored this, changed my config via menuconfig, recompiled and rebooted 
> and ACPI was gone ;-(
> 
> After copying my old config and "make oldconfig", everything was back to 
> normal. Unfortunately i wasn't able to reproduce this error.
> 
> I just wanted to let you know...

Did you accidentially enable "CPU Enumeration Only" in the
"ACPI support" menu?

If this isn't the problem, please send your .config.

>  Jan-Hinnerk

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

