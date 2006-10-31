Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423804AbWJaTJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423804AbWJaTJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 14:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423466AbWJaTJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 14:09:57 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4112 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1423804AbWJaTJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 14:09:56 -0500
Date: Tue, 31 Oct 2006 20:09:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc3] i386/io_apic: fix compiler warning in create_irq
Message-ID: <20061031190955.GU27968@stusta.de>
References: <tkrat.b1c929dd899e625a@s5r6.in-berlin.de> <20061030090231.GA27146@elte.hu> <20061030170445.1dedce1e.akpm@osdl.org> <1162287457.15286.186.camel@earth> <20061031014914.9af0dde9.akpm@osdl.org> <20061031111502.GA21450@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061031111502.GA21450@elte.hu>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 12:15:02PM +0100, Ingo Molnar wrote:
>...
> we definitely do not want to hide these places. They both make the code 
> less readable (why initialize it to some value if that value is never 
> used) and they hide the problem from the GCC folks too.

What about cases where it's technically impossible for gcc to ever see 
that a variable actually gets initialized?

> 	Ingo

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

