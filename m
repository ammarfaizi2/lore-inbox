Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbVBQWuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVBQWuo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 17:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVBQWun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 17:50:43 -0500
Received: from gate.crashing.org ([63.228.1.57]:16809 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261211AbVBQWti (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 17:49:38 -0500
Subject: Re: [PATCH] quiet non-x86 option ROM warnings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Jesse Barnes <jbarnes@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <9e4733910502170956e00a869@mail.gmail.com>
References: <200502151557.06049.jbarnes@sgi.com>
	 <200502170929.54100.jbarnes@sgi.com>
	 <9e47339105021709321dc72ab2@mail.gmail.com>
	 <200502170945.30536.jbarnes@sgi.com>
	 <9e4733910502170956e00a869@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 18 Feb 2005 09:48:03 +1100
Message-Id: <1108680484.5665.11.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-17 at 12:56 -0500, Jon Smirl wrote:
> On Thu, 17 Feb 2005 09:45:30 -0800, Jesse Barnes <jbarnes@sgi.com> wrote:
> > Ok, how does this one look to you guys?  The r128 driver would need similar
> > fixes.
> 
> Do any of the radeon ROMs store multiple images in different formats?
> Should the radeon driver loop throught the ROM images looking for one
> that it can understand, or is there alway only a single image? If ATI
> wanted to they could make ROMs with both x86 and OpenFirmware images
> on them.

While it's possible, I don't think it's actually done for radeon's (but
may for other video cards). Anyway as I wrote earlier, what about a
helper that deal with all these things ?

Ben.


