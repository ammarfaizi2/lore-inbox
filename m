Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266783AbUBRABs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 19:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266785AbUBRABs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 19:01:48 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:16375 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266783AbUBRAAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 19:00:37 -0500
Date: Wed, 18 Feb 2004 01:00:28 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: zippel@linux-m68k.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       GCS <gcs@lsc.hu>, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       vandrove@vc.cvut.cz
Subject: Re: Linux 2.6.3-rc4
Message-ID: <20040218000028.GR1308@fs.tum.de>
References: <Pine.LNX.4.58.0402161945540.30742@home.osdl.org> <20040217184543.GA18495@lsc.hu> <Pine.LNX.4.58.0402171107040.2154@home.osdl.org> <20040217200545.GP1308@fs.tum.de> <Pine.LNX.4.58.0402171214230.2154@home.osdl.org> <20040217225905.GQ1308@fs.tum.de> <Pine.LNX.4.58.0402171503150.2154@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402171503150.2154@home.osdl.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 17, 2004 at 03:11:08PM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 17 Feb 2004, Adrian Bunk wrote:
> > 
> > No, I2C_ALGOBIT depends on I2C.
> > 
> > > That's really what the true dependency is, logically.
> > 
> > Below is a suggested fix that lets FB_RADEON_I2C select I2C.
> 
> Thinking about it, this does the wrong thing for _another_ reason.
> 
> Basically, if you compile radeonfb as a module, and say "Y" to RADEON_I2C, 
> then that should _not_ force I2C to be built-in to the kernel, but that 
> is in fact exactly what this would force.
>...

I don't claim to fully understand the 2.6 Kconfig language, but 
according to my testings my patch does exactly what you describe.

> 			Linus

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

