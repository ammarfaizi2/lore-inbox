Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262930AbVDHTF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262930AbVDHTF0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 15:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbVDHTF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 15:05:26 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:18182 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262930AbVDHTFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 15:05:02 -0400
Date: Fri, 8 Apr 2005 21:05:00 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Franco Sensei <senseiwa@tin.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [INFO] Kernel strict versioning
Message-ID: <20050408190500.GF15688@stusta.de>
References: <4256C89C.4090207@tin.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4256C89C.4090207@tin.it>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 01:08:28PM -0500, Franco Sensei wrote:
>...
> Actually changing a kernel results in creating a /lib/modules/version 
> directory, creating a heavy confusion for a user, especially when 
> compiling other modules outside the official kernel release: he juts 
> looses the modules and has to recompile them.
> 
> I was wondering about the feasibility of handling just a MAJOR.MINOR 
> versioning. This would be quite an increment for a user to mantain his 
> kernel. Modules can still be loaded and found. We would have a single 
> /lib/modules/2.6 being much compatible with other modules, working with 
> 2.6.x and 2.6.y without any difficulty. Also the source tree from a 
> user's point of view is much cleaner, identifying the ongoing kernel 
> much easily.
>...

This has nothing to do with versioning.

You are asking for ABI compatibility between different kernel versions.

There is no stable ABI between different kernel versions and there will 
never be one. Please read Documentation/stable_api_nonsense.txt for 
details.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

