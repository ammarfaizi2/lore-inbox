Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264948AbSJWMkp>; Wed, 23 Oct 2002 08:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264951AbSJWMkp>; Wed, 23 Oct 2002 08:40:45 -0400
Received: from [195.223.140.120] ([195.223.140.120]:30996 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S264948AbSJWMko>; Wed, 23 Oct 2002 08:40:44 -0400
Date: Wed, 23 Oct 2002 14:46:59 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Srihari Vijayaraghavan <harisri@bigpond.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20pre11aa1
Message-ID: <20021023124659.GF30182@dualathlon.random>
References: <20021018145204.GG23930@dualathlon.random> <200210222048.05592.harisri@bigpond.com> <20021022145528.GW19337@dualathlon.random> <200210232227.47721.harisri@bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210232227.47721.harisri@bigpond.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 10:27:47PM +1000, Srihari Vijayaraghavan wrote:
> module.c:7:28: linux/rcupdate.h: No such file or directory
> module.c: In function `free_module':
> module.c:1082: warning: implicit declaration of function `synchronize_kernel'
> make[2]: *** [module.o] Error 1
> make[1]: *** [first_rule] Error 2
> make: *** [_dir_kernel] Error 2

Ok, please try to backout 2.4.20pre11aa1/00_reduce-module-races-1.
I just moved it into the 20 serie. that should fix this bit.

Andrea
