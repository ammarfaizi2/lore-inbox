Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965133AbVKHRCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965133AbVKHRCo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 12:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030258AbVKHRCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 12:02:44 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18705 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965133AbVKHRCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 12:02:43 -0500
Date: Tue, 8 Nov 2005 18:02:43 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386: stand-alone CONFIG_PAE
Message-ID: <20051108170243.GA3847@stusta.de>
References: <4370AEE1.76F0.0078.0@novell.com> <4370E69F.76F0.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4370E69F.76F0.0078.0@novell.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2005 at 05:55:43PM +0100, Jan Beulich wrote:
>...
> Also appropriately qualify both options depending on configured
> minimum processor type.

With the current semantics of the cpu options this is wrong:
M386 is a synonym for "kernel runs on all cpus".

> From: Jan Beulich <jbeulich@novell.com>
> 
> (actual patch attached)

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

