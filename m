Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264371AbTDKPQV (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 11:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264380AbTDKPQU (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 11:16:20 -0400
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:27629 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id S264371AbTDKPQT (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 11:16:19 -0400
Date: Fri, 11 Apr 2003 17:37:11 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: John Bradford <john@grabjohn.com>
Cc: Vikram Rangnekar <vicky@freebsdcluster.net>, linux-kernel@vger.kernel.org
Subject: Re: kernel hcking
Message-ID: <20030411153711.GE25862@wind.cocodriloo.com>
References: <20030411170709.A33459@freebsdcluster.dk> <200304111524.h3BFObYL001454@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304111524.h3BFObYL001454@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 04:24:37PM +0100, John Bradford wrote:
> > I'm a kernel newbie and just wanted to know what do most kernel hackers do
> > when working on the kernel say 2.5 when you make changes do u need to
> > recompile the kernel and reboot the machine to test your small modification
> > or do people use something like bochs.
> 
> A lot of developers have multiple physical machines, which makes
> testing various different kernels a lot easier.
> 
> > Also every time you makes changes in the kernel it must be hell to
> > recompile the whole thing
> 
> If you are testing kernels on a separate machine to the one you are
> compiling on, and therefore not rebooting, it's not much of a problem
> - with enough RAM, most or all of the kernel source will be cached,
> and you can compile a kernel in three to five minutes on a fast
> machine.

John, you mean a "make clean && make bzImage" takes you only about 4
minutes??? I would like to know more details about .config, machine
specs, compiler and so on :)

And no doubt having enough RAM to cache all the tree is really good :)

Greets, Antonio.
