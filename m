Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261637AbVC1A1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbVC1A1i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 19:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbVC1A1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 19:27:37 -0500
Received: from harlech.math.ucla.edu ([128.97.4.250]:36996 "EHLO
	harlech.math.ucla.edu") by vger.kernel.org with ESMTP
	id S261637AbVC1A13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 19:27:29 -0500
Date: Sun, 27 Mar 2005 16:27:25 -0800 (PST)
From: Jim Carter <jimc@math.ucla.edu>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disc driver is module, software suspend fails
In-Reply-To: <20050325081438.GA17245@elf.ucw.cz>
Message-ID: <Pine.LNX.4.61.0503271623150.5513@xena.cft.ca.us>
References: <Pine.LNX.4.61.0503242248530.7785@xena.cft.ca.us>
 <20050325081438.GA17245@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Mar 2005, Pavel Machek wrote:

> There's another feature that enables you to start resume manually with
> some echo to /sys... Perhaps it needs to be documented better, I'm
> looking for a patch ;-).

But how can it resume from a swap device for which it has no driver?
Even if you copied the needed module(s) onto the swap device, the kernel
needs the modules to be loaded before it can read anything.  The driver 
would be there if resuming happened after the initrd loaded it.  But
I wasn't able to make that actually work.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
