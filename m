Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030427AbVKPSe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030427AbVKPSe7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 13:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030428AbVKPSe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 13:34:59 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:50959 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030427AbVKPSe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 13:34:59 -0500
Date: Wed, 16 Nov 2005 19:34:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Bernd Petrovitsch <bernd@firmix.at>
Cc: "Wed, 16 Nov 2005 00:41:11 +0100" <grundig@teleline.es>,
       Arjan van de Ven <arjan@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051116183458.GN5735@stusta.de>
References: <20051116004111.45f3f704.grundig@teleline.es> <1132131854.1600.12.camel@tara.firmix.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1132131854.1600.12.camel@tara.firmix.at>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2005 at 10:04:14AM +0100, Bernd Petrovitsch wrote:
> On Wed, 2005-11-16 at 00:41 +0100, Wed, 16 Nov 2005 00:41:11 +0100
>                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>                                    Interesting Name.
> wrote:
> > > documentation for broadcom wireless:
> > > http://bcm-specs.sipsolutions.net/
> > > embrionic driver based on this spec:
> > > http://bcm43xx.berlios.de/
> > 
> > 
> > Maybe a good deal would be to delay the 4K patch until some preliminary
> > version of those is merged? 
> 
> Set the default value to "4k" and - to streß it further - remove the
> questions on `make *config` so that sufficiently interesting people must
> edit by hand after searching for it.

If you are sufficiently interested, reverting my patch would be more 
simple than manually hacking a Kconfig file.

> This will give the correct impression for everyone where it will go,
> possibly raises the awareness of this area (WLAN drivers) and it doesn't
> break ATM anything seriously.
> 
> 	Bernd

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

