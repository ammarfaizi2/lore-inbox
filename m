Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964955AbVKITAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955AbVKITAU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 14:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbVKITAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 14:00:20 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:275 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932444AbVKITAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 14:00:19 -0500
Date: Wed, 9 Nov 2005 20:00:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/39] NLKD/i386 - core adjustments
Message-ID: <20051109190017.GB4047@stusta.de>
References: <43720F5E.76F0.0078.0@novell.com> <43720F95.76F0.0078.0@novell.com> <43720FBA.76F0.0078.0@novell.com> <43720FF6.76F0.0078.0@novell.com> <43721024.76F0.0078.0@novell.com> <4372105B.76F0.0078.0@novell.com> <43721119.76F0.0078.0@novell.com> <43721142.76F0.0078.0@novell.com> <43721184.76F0.0078.0@novell.com> <437211B6.76F0.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437211B6.76F0.0078.0@novell.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2005 at 03:11:51PM +0100, Jan Beulich wrote:
> The core i386 NLKD adjustments to pre-existing code.
> 
> Signed-Off-By: Jan Beulich <jbeulich@novell.com>
> 
> (actual patch attached)

If your code doesn't work with 4k stacks you have a problem because
8k stacks will soon be removed (my goal is 2.6.16, perhaps one or two 
releases later).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

