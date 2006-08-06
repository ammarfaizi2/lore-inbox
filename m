Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWHFXK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWHFXK0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 19:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWHFXK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 19:10:26 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4615 "EHLO spitz.ucw.cz")
	by vger.kernel.org with ESMTP id S1750761AbWHFXKZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 19:10:25 -0400
Date: Sun, 6 Aug 2006 23:10:13 +0000
From: Pavel Machek <pavel@ucw.cz>
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Suspend on Dell D420
Message-ID: <20060806231013.GD4205@ucw.cz>
References: <20060804162300.GA26148@uio.no> <200608050126.57060.rjw@sisk.pl> <20060805082321.GB27129@uio.no> <200608051108.01180.rjw@sisk.pl> <20060806115043.GA30671@uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060806115043.GA30671@uio.no>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> No idea whether it's related. FWIW, resume didn't work with maxcpus=1 on boot
> >> either, so I'm not really sure how related it is.
> > Hm, could you please try it with a non-SMP kernel?
> 
> Compiling straight 2.6.17 with CONFIG_SMP=n suspends and resumes just fine.

Interesting... I guess getting some dump where it hangs is not an
option? Does video work for you during resume?

Can you try minimal drivers? It works for other people (smp too), so
it may be driver problem (althrough it looks unlikely)
							Pavel

-- 
Thanks for all the (sleeping) penguins.
