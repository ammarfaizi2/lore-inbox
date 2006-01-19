Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161467AbWASWpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161467AbWASWpE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 17:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161466AbWASWpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 17:45:04 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:57607 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161467AbWASWpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 17:45:03 -0500
Date: Thu, 19 Jan 2006 23:45:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, perex@suse.cz
Subject: Re: RFC: OSS driver removal, a slightly different approach
Message-ID: <20060119224501.GC19398@stusta.de>
References: <20060119174600.GT19398@stusta.de> <m3ek34vucz.fsf@defiant.localdomain> <1137709308.8471.77.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137709308.8471.77.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 10:21:47PM +0000, Alan Cox wrote:
> On Iau, 2006-01-19 at 21:24 +0100, Krzysztof Halasa wrote:
>...
> > > SOUND_WAVEARTIST
> 
> Not sure

config SOUND_WAVEARTIST
        tristate "Netwinder WaveArtist"
        depends on ARM && SOUND_OSS && ARCH_NETWINDER
        help
          Say Y here to include support for the Rockwell WaveArtist sound
          system.  This driver is mainly for the NetWinder.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

