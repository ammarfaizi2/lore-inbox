Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267303AbUHIWFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267303AbUHIWFz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 18:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267307AbUHIWFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 18:05:55 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:35295 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267303AbUHIWFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 18:05:48 -0400
Date: Tue, 10 Aug 2004 00:05:40 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, zippel@linux-m68k.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] select FW_LOADER -> depends HOTPLUG
Message-ID: <20040809220540.GG26174@fs.tum.de>
References: <20040809195656.GX26174@fs.tum.de> <20040809202603.GA7776@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040809202603.GA7776@logos.cnet>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 05:26:03PM -0300, Marcelo Tosatti wrote:
> 
> BTW last time I tried to turn CONFIG_FW_LOADER off on 2.6.8-rc3 I was not able
> to do so... Is that expected?

Yes:
  cd linux-2.6.7
  find . -name Kconfig\* | xargs grep select | grep FW_LOADER

AFAIK there's currently no way implemented to easyly disable an option 
that is selected by other options.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

