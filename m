Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbTKYR7h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 12:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262762AbTKYR7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 12:59:36 -0500
Received: from smithers.nildram.co.uk ([195.112.4.54]:58628 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S262491AbTKYR7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 12:59:34 -0500
Date: Tue, 25 Nov 2003 18:00:16 +0000
From: Joe Thornber <thornber@sistina.com>
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Cc: Joe Thornber <thornber@sistina.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Patch 3/5] dm: make v4 of the ioctl interface the default
Message-ID: <20031125180016.GI524@reti>
References: <20031125162451.GA524@reti> <20031125163313.GD524@reti> <3FC387A0.8010600@backtobasicsmgmt.com> <20031125170503.GG524@reti> <3FC38E26.9080602@backtobasicsmgmt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FC38E26.9080602@backtobasicsmgmt.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 25, 2003 at 10:15:18AM -0700, Kevin P. Fleming wrote:
> Joe Thornber wrote:
> 
> >For the last few months the tools have supported both v1 and v4
> >interfaces, allowing people to roll back to older kernels.  I will
> >update the Kconfig help as you suggest to be more specific about the
> >tool versions.
> 
> My biggest concern here is that even if someone downloads the latest 
> device-mapper tools tarball and compiles it on their system, unless they 
> specifically point it at 2.6 kernel headers it won't compile in v4 ioctl 
> support, so they could be unpleasantly surprised.

The tools build against their own copies of the header files.

- Joe
