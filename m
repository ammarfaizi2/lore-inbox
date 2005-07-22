Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262154AbVGVUOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbVGVUOX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 16:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbVGVUOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 16:14:22 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:42505 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262154AbVGVUOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 16:14:21 -0400
Date: Fri, 22 Jul 2005 22:14:16 +0200
From: Adrian Bunk <bunk@stusta.de>
To: christos gentsis <christos_gentsis@yahoo.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel optimization
Message-ID: <20050722201416.GM3160@stusta.de>
References: <42E14134.1040804@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E14134.1040804@yahoo.co.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2005 at 07:55:48PM +0100, christos gentsis wrote:

> hello

Hi Chris,

> i would like to ask if it possible to change the optimization of the 
> kernel from -O2 to -O3 :D, how can i do that? if i change it to the top 
> level Makefile does it change to all the Makefiles?

search for the line with
  CFLAGS          += -O2
and change this to -O3.

This works for most Makefile's except for the one's that manually
set -Os.

> And let's say that i change it... does this generate any problems with 
> the space that the kernel will take? (the kernel will be much larger)

It's completely untested.
And since it's larger, it's also slower.

> Thanks
> Chris

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

