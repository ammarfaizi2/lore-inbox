Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbUGVTdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbUGVTdq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 15:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265249AbUGVTdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 15:33:46 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:45013 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261300AbUGVTdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 15:33:44 -0400
Date: Thu, 22 Jul 2004 21:33:37 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: corbet@lwn.net, linux-kernel@vger.kernel.org
Subject: Re: New dev model (was [PATCH] delete devfs)
Message-ID: <20040722193337.GE19329@fs.tum.de>
References: <40FEEEBC.7080104@quark.didntduck.org> <20040721231123.13423.qmail@lwn.net> <20040721235228.GZ14733@fs.tum.de> <20040722025539.5d35c4cb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040722025539.5d35c4cb.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

my personal opinon is that this new development model isn't a good 
idea from the point of view of users:

There's much worth in having a very stable kernel. Many people use for 
different reasons self-compiled ftp.kernel.org kernels. In 2.4, it took 
until at about 2.4.18 or 2.4.22 [1] until it was reasonable stable. 
Today, most code in the 2.4 kernel has had several years of testing and 
it's therefore quite stable even in unusual configurations. Besides 
this, an upgrade like from 2.4.25 to 2.4.26 is pretty low-risk since  
there shouldn't be any changes that might break existing setups.

If your work together with Linus is so effective, why can't you both do 
all the changes in a new 2.7 tree that includes also all incompatible 
and potential dangerous changes as well as the removal of obsolete code 
like devfs or OSS. I don't see the negative effect if a 2.7 branch was 
created today and together with a feature freeze for 2.7 three months  
from now this might result in a 2.8.0 before christmas [2] that contains 
all the new features/removals/changes while 2.6 will evolve further into 
a rock-solid stable kernel.

cu
Adrian

[1] there are different opinions on the exact version number, but it was
    definitely not 2.4.10
[2] perhaps a bit optimistic, but it shouldn't be years from now

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

