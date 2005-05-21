Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261694AbVEUHl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbVEUHl0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 03:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVEUHl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 03:41:26 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:31247 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261694AbVEUHlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 03:41:17 -0400
Date: Sat, 21 May 2005 09:41:10 +0200
From: Adrian Bunk <bunk@stusta.de>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove the obsolete raw driver
Message-ID: <20050521074110.GS5112@stusta.de>
References: <20050521001925.GQ5112@stusta.de> <20050521012505.GD2057@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050521012505.GD2057@holomorphy.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2005 at 06:25:05PM -0700, William Lee Irwin III wrote:
> On Sat, May 21, 2005 at 02:19:25AM +0200, Adrian Bunk wrote:
> > Since kernel 2.6.3 the Kconfig text explicitely stated this driver was 
> > obsolete.
> > It seems to be time to remove it.
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> 9 point releases is nowhere long enough. This removal needs to wait for
> similar amounts of time as other removed interfaces (c.f. devfs, which
> is far more offensive).
> 
> In general there are staging rules for this sort of affair, and although
> I'm no expert in their fine points, nor can I even say what the exact
> criteria are, but it's rather clear in this instance it's over the line.
> I suspect a major release, planned as a staging ground for things like
> e.g. this and removing devfs, would be the most appropriate time for it.

The current rules are simply "put it for 6-12 months in 
Documentation/feature-removal-schedule.txt and remove it then".

2.6.3 is more than a year go, and the date when the raw driver was 
declared obsolete predates the introduction of 
feature-removal-schedule.txt (at that time, we were still in the belief
a 2.7 kernel would come some day).

> -- wli

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

