Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbVBOT0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbVBOT0b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 14:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbVBOT0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 14:26:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56778 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261830AbVBOT0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 14:26:20 -0500
Date: Tue, 15 Feb 2005 19:26:18 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Alexey Dobriyan <adobriyan@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] procfs: Fix sparse warnings
Message-ID: <20050215192618.GL8859@parcelfarce.linux.theplanet.co.uk>
References: <200502151455.55711.adobriyan@mail.ru> <20050215115934.GK8859@parcelfarce.linux.theplanet.co.uk> <200502151512.37774.adobriyan@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502151512.37774.adobriyan@mail.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 03:12:37PM +0200, Alexey Dobriyan wrote:
> On Tuesday 15 February 2005 13:59, Al Viro wrote:
> > On Tue, Feb 15, 2005 at 02:55:55PM +0200, Alexey Dobriyan wrote:
> > 
> > Let's hold this kind of stuff until 2.6.11, OK?
> > 
> > 	Al, sitting on more than a megabyte of such patches...
> 
> Could you send diffstat or something? I did "make allyesconfig" with
> -Wbitwise and digging slowly from the beginning. Now at fs/qnx4.

Umm...  Let's do it that way: I'll get carving the sucker up to relatively
sane point and post it again (-bird, that is).  Give me until tomorrow
morning and then feel free to send stuff my way - I'll merge it and feed
upstream when 2.6.11 opens (credited, obviously).

Keep in mind that for endianness patches you *really* need to check on
at least some big-endian targets and both on 32 and 64bit ones.  I've
got a decent cross-build environment (tracking 14 targets now); if you need 
help with setting up something similar, I can help.
