Return-Path: <linux-kernel-owner+w=401wt.eu-S932100AbWLNJZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWLNJZR (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 04:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbWLNJZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 04:25:16 -0500
Received: from jdi.jdi-ict.nl ([82.94.239.5]:40035 "EHLO jdi.jdi-ict.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932100AbWLNJZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 04:25:14 -0500
Date: Thu, 14 Dec 2006 10:25:02 +0100 (CET)
From: Igmar Palsenberg <i.palsenberg@jdi-ict.nl>
X-X-Sender: igmar@jdi.jdi-ict.nl
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, npiggin@suse.de, erich <erich@areca.com.tw>
Subject: Re: 2.6.16.32 stuck in generic_file_aio_write()
In-Reply-To: <20061214011042.7b279be6.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0612141012200.15891@jdi.jdi-ict.nl>
References: <Pine.LNX.4.58.0611291329060.18799@jdi.jdi-ict.nl>
 <20061130212248.1b49bd32.akpm@osdl.org> <Pine.LNX.4.58.0612010926030.31655@jdi.jdi-ict.nl>
 <Pine.LNX.4.58.0612042201001.14643@jdi.jdi-ict.nl>
 <Pine.LNX.4.58.0612061615550.24526@jdi.jdi-ict.nl> <20061206074008.2f308b2b.akpm@osdl.org>
 <Pine.LNX.4.58.0612070940590.28683@jdi.jdi-ict.nl>
 <Pine.LNX.4.58.0612071328030.9115@jdi.jdi-ict.nl>
 <Pine.LNX.4.58.0612140912010.30202@jdi.jdi-ict.nl> <20061214004213.13149a48.akpm@osdl.org>
 <Pine.LNX.4.58.0612140953080.9623@jdi.jdi-ict.nl> <20061214011042.7b279be6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.1.12 (jdi.jdi-ict.nl [127.0.0.1]); Thu, 14 Dec 2006 10:25:03 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > See below. The other machine is mostly identifical, except for i8042 
> > missing (probably due to running an older kernel, or small differences in 
> > the kernel config).
> > 
> 
> Does the other machine have the same problems?

No, but that machine has a lot less disk and networkactivity.
 
> Are you able to rule out a hardware failure?

100% ? No, but the hardware is relatively new (about a year old), and of 
good quality. It's hard to reprodure, so looking at it when it starts to 
fault isn't possible either :(

> The disk interrupt is unshared, which rules out a few software problems, I
> guess.

Indeed. Bah, I hate these kind of things :(



Regards,


	Igmar
