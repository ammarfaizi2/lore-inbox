Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265600AbUAPQC3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 11:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265604AbUAPQC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 11:02:29 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:20484 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S265600AbUAPQC0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 11:02:26 -0500
Date: Fri, 16 Jan 2004 17:02:12 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jeff Dike <jdike@addtoit.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] /dev/anon
Message-ID: <20040116170212.B2809@pclin040.win.tue.nl>
References: <200401132021.i0DKLBhg002890@ccure.user-mode-linux.org> <Pine.GSO.4.58.0401161314590.14892@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.58.0401161314590.14892@waterleaf.sonytel.be>; from geert@linux-m68k.org on Fri, Jan 16, 2004 at 01:16:02PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 16, 2004 at 01:16:02PM +0100, Geert Uytterhoeven wrote:
> On Tue, 13 Jan 2004, Jeff Dike wrote:
> > If this should be maintained out-of-tree, should I get an official minor for
> > it anyway, or just unofficially use the first unused misc minor (10 in 2.4,
> > 11 in 2.6)?
> 
> Apparently there's a hole in the list in 2.6.[01] (/dev/kmsg has 11), so you
> can use 10 for both 2.4 and 2.6.

Yes. 6 was /dev/core, added 0.98p3, removed 0.99p13X.
10 was reserved for /dev/aio, but when aio was
implemented it was done differently. So 10 has never been used.

