Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261903AbVC1WrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbVC1WrO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 17:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbVC1WrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 17:47:13 -0500
Received: from fire.osdl.org ([65.172.181.4]:31453 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261903AbVC1WrK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 17:47:10 -0500
Date: Mon, 28 Mar 2005 14:46:34 -0800
From: Chris Wright <chrisw@osdl.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Chris Wright <chrisw@osdl.org>, Pekka Enberg <penberg@cs.helsinki.fi>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] isofs: unobfuscate rock.c
Message-ID: <20050328224634.GO30522@shell0.pdx.osdl.net>
References: <ie2p3m.2u2ccu.3z4p19m1j53m9pob6l5ceeebq.refire@cs.helsinki.fi> <20050328200252.GN28536@shell0.pdx.osdl.net> <20050328223048.GA2741@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050328223048.GA2741@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andries Brouwer (aebr@win.tue.nl) wrote:
> On Mon, Mar 28, 2005 at 12:02:52PM -0800, Chris Wright wrote:
> > * Pekka Enberg (penberg@cs.helsinki.fi) wrote:
> > > This patch removes macro obfuscation from fs/isofs/rock.c and cleans it up
> > > a bit to make it more readable and maintainable. There are no functional
> > > changes, only cleanups. I have only tested this lightly but it passes
> > > mount and read on small Rock Ridge enabled ISO image.
> > 
> > You might want to look at current -mm.  Andrew has a series or 13 or so
> > patches that do very similar cleanup.  Perhaps you could start from there?
> 
> Good! When Linus asked I audited rock.c and also did rather similar polishing -
> it happens automatically if one looks at this code. But it seems everybody is
> doing this right now, so I must wait a few weeks and see what got into Linus'
> tree. Linus plugged many but not all holes. (Maybe you did more?)

I plugged one more (in 2.6.11.6 and in Linus' tree), and Andrew plugged
yet another (last patch in his iso/rock cleanup series).  More eyes
the better.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
