Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261322AbVB0BDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbVB0BDe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 20:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbVB0BDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 20:03:34 -0500
Received: from fire.osdl.org ([65.172.181.4]:36574 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261322AbVB0BDd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 20:03:33 -0500
Date: Sat, 26 Feb 2005 17:04:21 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] partitions/msdos.c
In-Reply-To: <16929.6319.149849.305237@hertz.ikp.physik.tu-darmstadt.de>
Message-ID: <Pine.LNX.4.58.0502261703140.25732@ppc970.osdl.org>
References: <20050226213459.GA21137@apps.cwi.nl>
 <16928.62091.346922.744462@hertz.ikp.physik.tu-darmstadt.de>
 <Pine.LNX.4.58.0502261424430.25732@ppc970.osdl.org> <20050226225203.GA25217@apps.cwi.nl>
 <Pine.LNX.4.58.0502261510030.25732@ppc970.osdl.org> <20050226234053.GA14236@apps.cwi.nl>
 <Pine.LNX.4.58.0502261546380.25732@ppc970.osdl.org>
 <16929.6319.149849.305237@hertz.ikp.physik.tu-darmstadt.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 27 Feb 2005, Uwe Bonnes wrote:
> 
> on a Suse 9.2 System with Suse Hotplug, the phantom partition was somehow
> recognized as Reiserfs, and then the Hotplug mechanism trying to mount the 
> bogus partition as a Reiser Filesystem ended in an Oops...

Heh. That oops would be interesting in itself, since it implies that 
reiserfs is not doing very well on the sanity-checking front. 

But yes, point taken.

		Linus
