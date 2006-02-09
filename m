Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932506AbWBIOQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbWBIOQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 09:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWBIOQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 09:16:29 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:46093 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932506AbWBIOQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 09:16:28 -0500
Date: Thu, 9 Feb 2006 15:16:27 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jes Sorensen <jes@sgi.com>
Cc: Matthew Wilcox <matthew@wil.cx>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Keith Owens'" <kaos@sgi.com>, "Luck, Tony" <tony.luck@intel.com>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let IA64_GENERIC select more stuff
Message-ID: <20060209141627.GD3524@stusta.de>
References: <20060208035112.GM3524@stusta.de> <200602080552.k185q9g07813@unix-os.sc.intel.com> <20060208115946.GN3524@stusta.de> <yq0d5hym0lq.fsf@jaguar.mkp.net> <20060208213825.GQ3524@stusta.de> <yq0zml0lmmg.fsf@jaguar.mkp.net> <20060209131802.GE1593@parisc-linux.org> <yq0r76cll25.fsf@jaguar.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq0r76cll25.fsf@jaguar.mkp.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2006 at 08:26:58AM -0500, Jes Sorensen wrote:
> >>>>> "Matthew" == Matthew Wilcox <matthew@wil.cx> writes:
>...
> >> - HP100 driver cannot be compiled on systems without ISA support in
> >> it's current state.
> 
> Matthew> I have it enabled on parisc without ISA or EISA.  More
> Matthew> details, please.
> 
> Generous use of isa_memcpy_toio, isa_readb etc. Those functions ought
> not be visible in a config where ISA is disabled.  Anybody who cares
> enough about this could easily fix the HP100 driver to deal with it,
> but it would require some reorganization of the code.
>...

A patch is already available:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/
  2.6.16-rc2/2.6.16-rc2-mm1/broken-out/
  remove-isa-legacy-functions-drivers-net-hp100c.patch

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

