Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbWCaPQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWCaPQN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 10:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWCaPQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 10:16:13 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:34827 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751118AbWCaPQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 10:16:12 -0500
Date: Fri, 31 Mar 2006 17:16:10 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [-mm patch] arch/i386/kernel/apic.c: make modern_apic() static
Message-ID: <20060331151610.GH3893@stusta.de>
References: <20060328003508.2b79c050.akpm@osdl.org> <20060331145648.GG3893@stusta.de> <200603311702.19669.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603311702.19669.ak@suse.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2006 at 05:02:19PM +0200, Andi Kleen wrote:
> On Friday 31 March 2006 16:56, Adrian Bunk wrote:
> > This patch makes a nnedlessly global function static.
> 
> Disagree. It will be likely used in more code in the future.

If this "likely" case becomes reality at any time in the future, 
reverting my patch will be trivial.

OTOH, I have seen too many cases where people have said "I will need 
this soon", and one year later it was still unused.

> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

