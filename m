Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263150AbUCMR6M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 12:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263148AbUCMR6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 12:58:11 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:11748 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263150AbUCMR5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 12:57:20 -0500
Date: Sat, 13 Mar 2004 18:57:13 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Bloat report 2.6.3 -> 2.6.4
Message-ID: <20040313175712.GY14833@fs.tum.de>
References: <20040312204458.GJ20174@waste.org> <20040312152206.61604447.akpm@osdl.org> <20040312235349.GK20174@waste.org> <20040313170839.GV14833@fs.tum.de> <20040313173331.GO20174@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040313173331.GO20174@waste.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2004 at 11:33:32AM -0600, Matt Mackall wrote:
> 
> I actually did explicitly note this problem in the part you clipped.

I clipped nothing, I quoted your _complete_ mail.

> But I think it's fair to say that new features that are on by default
> are in fact bloat in some sense.

Perhaps in some sense, but not in any interesting sense.

For the average computer you can buy at your supermarket today it isn't 
very interesting whether the kernel is bigger by 1 MB or not.

People who need to care about the size of the kernel [1] use hand-tuned 
.config's that are far away from defconfig - and those people wouldn't 
enable unneeded features that are on by default.

You use a metric "size increase of a defconfig kernel [2]", and I simply 
claim that this metric doesn't measure anything useful for practical 
purposes.

cu
Adrian

[1] e.g. for small embedded systems, very old computers or
    boot _floppies_
[2] modulo some compensation for changed defconfig's

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

