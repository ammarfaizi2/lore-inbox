Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262569AbVDPCcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbVDPCcM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 22:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262578AbVDPCcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 22:32:12 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:41740 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262569AbVDPCcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 22:32:08 -0400
Date: Sat, 16 Apr 2005 04:32:06 +0200
From: Adrian Bunk <bunk@stusta.de>
To: John M Collins <jmc@xisl.com>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Lars Marowsky-Bree <lmb@suse.de>,
       Helge Hafting <helge.hafting@aitel.hist.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Exploit in 2.6 kernels
Message-ID: <20050416023206.GH4831@stusta.de>
References: <1113298455.16274.72.camel@caveman.xisl.com> <425BBDF9.9020903@ev-en.org> <1113318034.3105.46.camel@caveman.xisl.com> <20050412210857.GT11199@shell0.pdx.osdl.net> <1113341579.3105.63.camel@caveman.xisl.com> <425CEAC2.1050306@aitel.hist.no> <20050413125921.GN17865@csclub.uwaterloo.ca> <20050413130646.GF32354@marowsky-bree.de> <20050413132308.GP17865@csclub.uwaterloo.ca> <1113400906.10763.20.camel@caveman.xisl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113400906.10763.20.camel@caveman.xisl.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2005 at 03:01:46PM +0100, John M Collins wrote:
>...
> Could I possibly make a suggestion for "make xconfig" in the kernel tree
> (and make other-kinds-of-config I suppose)?
> 
> I currently routinely copy the ".config" out of the previous kernel tree
> before I start to save working through questions about sound cards I
> never heard of and so forth.
> 
> Could it perhaps optionally initialise most of the settings to fit the
> current machine and/or grab the last lot of settings
> from /proc/config.gz?


  zcat /proc/config.gz > .config


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

