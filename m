Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbULAEy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbULAEy1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 23:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbULAEy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 23:54:27 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:10771 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261163AbULAEyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 23:54:24 -0500
Date: Wed, 1 Dec 2004 05:54:22 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, dm-devel@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] dm: remove unused functions (fwd)
Message-ID: <20041201045422.GF2650@stusta.de>
References: <20041129022940.GQ4390@stusta.de> <20041130230525.GC24233@agk.surrey.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041130230525.GC24233@agk.surrey.redhat.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2004 at 11:05:25PM +0000, Alasdair G Kergon wrote:
> On Mon, Nov 29, 2004 at 03:29:40AM +0100, Adrian Bunk wrote:
> > Please apply or comment on it.
>  
> Please check *why* the functions aren't used first.
> 
> e.g. An alloc function with a corresponding free that
> never gets called suggests a leak to me...

I have to admit that I don't thoroughly check the code where I find
unused code. That's why I asked for comments on this patch. Ususally the 
maintainers of the code in question know best whether such a patch is 
correct or not.

Simply consider my patches as some kind of "list of unused functions".

> Alasdair

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

