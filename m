Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264146AbTHXBFq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 21:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264163AbTHXBFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 21:05:46 -0400
Received: from kom-pc-aw.ethz.ch ([129.132.66.20]:11239 "HELO
	kom-pc-aw.ethz.ch") by vger.kernel.org with SMTP id S264146AbTHXBFk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 21:05:40 -0400
Date: Sun, 24 Aug 2003 03:05:39 +0200
From: Arno Wagner <wagner@tik.ee.ethz.ch>
To: Diego Calleja Garc?a <diegocg@teleline.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: 2.6.0-test3: dmesg buffer still too small
Message-ID: <20030824010539.GA5682@tik.ee.ethz.ch>
References: <20030823151336.GB4266@tik.ee.ethz.ch> <20030823224255.34fee3a0.diegocg@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030823224255.34fee3a0.diegocg@teleline.es>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 23, 2003 at 10:42:55PM +0200, Diego Calleja Garc?a wrote:
> El Sat, 23 Aug 2003 17:13:36 +0200 Arno Wagner <wagner@tik.ee.ethz.ch> escribi?:
> 
> > b) Add a configuration option to set the buffer size
> >    in kernel configuration.
> > 
>   (15) Kernel log buffer size (16 => 64KB, 17 => 128KB
> 
> 
> Under "general setup" at least in -test3/4

Not displayed by "make menuconfig" and "make config" 
unfortunately.

I found the config variable CONFIG_LOG_BUF_SHIFT
on .config. So this is actually a problem with the config 
tools and not the available config variables...

What did you use that displayed the option? Or is there
some other option that hides the choice of log
buffer? I have a stock 2.4.6-test3 from kernel.org

Arno
-- 
Arno Wagner, Communication Systems Group, ETH Zuerich, wagner@tik.ee.ethz.ch
GnuPG:  ID: 1E25338F  FP: 0C30 5782 9D93 F785 E79C  0296 797F 6B50 1E25 338F
----
For every complex problem there is an answer that is clear, simple, 
and wrong. -- H L Mencken
