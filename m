Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbUBUNy6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 08:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbUBUNy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 08:54:58 -0500
Received: from gprs154-206.eurotel.cz ([160.218.154.206]:40320 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261555AbUBUNy5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 08:54:57 -0500
Date: Sat, 21 Feb 2004 14:54:39 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Marc <pcg@goof.com>, Jamie Lokier <jamie@shareable.org>,
       Marc Lehmann <pcg@schmorp.de>, viro@parcelfarce.linux.theplanet.co.uk,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re: JFS default behavior)
Message-ID: <20040221135439.GA310@elf.ucw.cz>
References: <200402150107.26277.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.58.0402141827200.14025@home.osdl.org> <20040216183616.GA16491@schmorp.de> <Pine.LNX.4.58.0402161040310.30742@home.osdl.org> <20040216200321.GB17015@schmorp.de> <Pine.LNX.4.58.0402161205120.30742@home.osdl.org> <20040216222618.GF18853@mail.shareable.org> <Pine.LNX.4.58.0402161431260.30742@home.osdl.org> <20040217071448.GA8846@schmorp.de> <Pine.LNX.4.58.0402170739580.2154@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402170739580.2154@home.osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> Which flies in the face of "Be strict in what you generate, be liberal in 
> what you accept". A lot of the functions are _not_ willing to be liberal 
> in what they accept. Which sometimes just makes the problem worse, for no 
> good reason.

Be liberal in what you accept used to be good rule... until security
became important. While it is still nice from ease-of-use viewpoint,
its bad when you want it secure.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
