Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266385AbUA3Cvr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 21:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266395AbUA3Cvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 21:51:47 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:51438 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266385AbUA3Cvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 21:51:46 -0500
Date: Fri, 30 Jan 2004 03:51:42 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc2-mm1
Message-ID: <20040130025142.GE3004@fs.tum.de>
References: <20040127233402.6f5d3497.akpm@osdl.org> <20040128083645.GI2650@boetes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040128083645.GI2650@boetes.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 28, 2004 at 09:36:23AM +0100, Han Boetes wrote:
> 
> Hmmm my build breaks with:
> 
>   LD      .tmp_vmlinux1
> arch/i386/kernel/built-in.o(.init.text+0x1342): In function `setup_memory':
> : undefined reference to `find_smp_config'
>...

You have a Voyager machine?
You didn't enable SMP support?

Could you retry the compilation with SMP support enabled?

> # Han

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

