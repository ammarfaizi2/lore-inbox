Return-Path: <linux-kernel-owner+w=401wt.eu-S1422975AbWLUX2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422975AbWLUX2w (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 18:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423125AbWLUX2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 18:28:52 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2789 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1422975AbWLUX2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 18:28:52 -0500
Date: Fri, 22 Dec 2006 00:28:50 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] mm: export cancel_dirty_page()
Message-ID: <20061221232850.GJ6993@stusta.de>
References: <20061221231328.GA21217@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061221231328.GA21217@elte.hu>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2006 at 12:13:28AM +0100, Ingo Molnar wrote:
> From: Ingo Molnar <mingo@elte.hu>
> Subject: [patch] export cancel_dirty_page()
> 
> export cancel_dirty_page() - it's used by hugetlbfs which can be 
> modular. (This makes my -git based kernel yum repository build again.)
>...

No, it can't be:

config HUGETLBFS
        bool "HugeTLB file system support"
        ^^^^

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

