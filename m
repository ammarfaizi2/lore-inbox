Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319472AbSIMAtY>; Thu, 12 Sep 2002 20:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319473AbSIMAtY>; Thu, 12 Sep 2002 20:49:24 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:12060 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S319472AbSIMAtX>; Thu, 12 Sep 2002 20:49:23 -0400
Date: Fri, 13 Sep 2002 02:54:40 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Stephen Lord <lord@sgi.com>
Cc: Samuel Flory <sflory@rackable.com>, Austin Gonyou <austin@coremetrics.com>,
       Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-xfs@oss.sgi.com
Subject: Re: 2.4.20pre5aa2
Message-ID: <20020913005440.GJ11605@dualathlon.random>
References: <20020911201602.A13655@pc9391.uni-regensburg.de> <1031768655.24629.23.camel@UberGeek.coremetrics.com> <20020911184111.GY17868@dualathlon.random> <3D81235B.6080809@rackable.com> <20020913002316.GG11605@dualathlon.random> <1031878070.1236.29.camel@snafu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1031878070.1236.29.camel@snafu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2002 at 07:47:48PM -0500, Stephen Lord wrote:
> How much memory is in the machine by the way? And Andrea, is the
> vmalloc space size reduced in the 3G user space configuration?

it's not reduced, it's the usual 128m.

BTW, I forgot to say that to really take advantage of CONFIG_2G one
should increase __VMALLOC_RESERVE too, it's not directly in function of
the CONFIG_2G.

Andrea
