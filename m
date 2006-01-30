Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWA3A7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWA3A7c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 19:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbWA3A7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 19:59:32 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:64005 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932099AbWA3A7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 19:59:31 -0500
Date: Mon, 30 Jan 2006 01:59:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: akpm@osdl.org, ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm4
Message-ID: <20060130005930.GE3777@stusta.de>
References: <20060129144533.128af741.akpm@osdl.org> <20060129233403.GA3777@stusta.de> <20060129154002.360c7294.rdunlap@xenotime.net> <20060129235853.GD3777@stusta.de> <20060129165123.58b62b36.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060129165123.58b62b36.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2006 at 04:51:23PM -0800, Randy.Dunlap wrote:
> On Mon, 30 Jan 2006 00:58:53 +0100 Adrian Bunk wrote:
>...
> > If we want to get rid of a long deprecated API (as in the 
> > virt_to_bus/bus_to_virt case), adding warnings could help making 
> > maintainers aware of the fact that the API is deprecated.
> 
> I seriously expect that the maintainers are already aware
> of that.  It's not new(s).
>...

Looking at which drivers still use this API, I'm seeing some drivers 
with active maintainers still using this API.

And for others, warnings might increase the probability of someone 
fixing them for getting rid of the warnings...

> ~Randy

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

