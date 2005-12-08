Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932699AbVLHXCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932699AbVLHXCH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 18:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932700AbVLHXCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 18:02:07 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:65295 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932699AbVLHXCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 18:02:05 -0500
Date: Fri, 9 Dec 2005 00:02:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Badari Pulavarty <pbadari@gmail.com>, Jaroslav Kysela <perex@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       alsa-devel@alsa-project.org
Subject: Re: 2.6.15-rc5-mm1
Message-ID: <20051208230203.GA23349@stusta.de>
References: <20051204232153.258cd554.akpm@osdl.org> <1134068983.21841.71.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134068983.21841.71.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2005 at 11:09:43AM -0800, Badari Pulavarty wrote:
> On Sun, 2005-12-04 at 23:21 -0800, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm1/
> 
> In file included from sound/pci/ens1371.c:2:
> sound/pci/ens1370.c: In function `snd_audiopci_probe':
> sound/pci/ens1370.c:2462: error: `spdif' undeclared (first use in this
> function)sound/pci/ens1370.c:2462: error: (Each undeclared identifier is
> reported only once
> sound/pci/ens1370.c:2462: error: for each function it appears in.)
> sound/pci/ens1370.c:2462: error: `lineio' undeclared (first use in this
> function)
> make[2]: *** [sound/pci/ens1371.o] Error 1
> make[2]: *** Waiting for unfinished jobs....

Jaroslav, this seems to come from your

  [ALSA] ens1371: added spdif and lineio module option

patch in the ALSA git tree if SUPPORT_JOYSTICK=n.

> Thanks,
> Badari

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

