Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbTKYRE5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 12:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbTKYRE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 12:04:57 -0500
Received: from smithers.nildram.co.uk ([195.112.4.54]:58896 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S261719AbTKYRE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 12:04:56 -0500
Date: Tue, 25 Nov 2003 17:05:03 +0000
From: Joe Thornber <thornber@sistina.com>
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Cc: Joe Thornber <thornber@sistina.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Patch 3/5] dm: make v4 of the ioctl interface the default
Message-ID: <20031125170503.GG524@reti>
References: <20031125162451.GA524@reti> <20031125163313.GD524@reti> <3FC387A0.8010600@backtobasicsmgmt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FC387A0.8010600@backtobasicsmgmt.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 25, 2003 at 09:47:28AM -0700, Kevin P. Fleming wrote:
> Joe Thornber wrote:
> 
> >Make the version-4 ioctl interface the default kernel configuration option.
> >If you have out of date tools you will need to use the v1 interface.
> 
> Actually, isn't the proper way to say this "if your tools are older than 
> X and/or were _not_ built against recent 2.6 headers you need to use the 
> v1 interface"?
> 
> Also, if you're going to change the default you should change the help 
> text correspondingly.

I would like to remove v1 support very shortly, making v4 the default
for a bit is just the next phase of this process.

For the last few months the tools have supported both v1 and v4
interfaces, allowing people to roll back to older kernels.  I will
update the Kconfig help as you suggest to be more specific about the
tool versions.

- Joe
