Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965000AbVLFSCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965000AbVLFSCt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 13:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbVLFSCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 13:02:25 -0500
Received: from mail.kroah.org ([69.55.234.183]:44780 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964824AbVLFSB2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 13:01:28 -0500
Date: Tue, 6 Dec 2005 09:54:22 -0800
From: Greg KH <greg@kroah.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>,
       Matthias Andree <matthias.andree@gmx.de>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051206175422.GG3084@kroah.com>
References: <20051203135608.GJ31395@stusta.de> <9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com> <20051203201945.GA4182@kroah.com> <9a8748490512031948m26b04d3ds9fbc652893ead40@mail.gmail.com> <20051204115650.GA15577@merlin.emma.line.org> <20051204232454.GG8914@kroah.com> <20051205062609.GA7096@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051205062609.GA7096@alpha.home.local>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2005 at 07:26:09AM +0100, Willy Tarreau wrote:
> Maybe you should just join forces, eg Chris and you to catch
> new patches, and Adrian to merge them to older kernels ? Every
> software maker always supports a few older releases for the
> people who need to stay on something stable, and it is clearly
> what is missing now in 2.6.

I don't think people realize that the -stable series only contains
patches that other people send us.  For the most part, Chris and I
aren't going out there and activly writing up fixes for some of these
issues, as we both don't have the time and energy to do this.

But if someone wants to start sending us more patches that do this, we
will be glad to incorporate them.  And as Chris said, we will be glad to
release an extra release for the last kernel if we have pending patches.

And also, anyone else can easily take over maintaining these kernel
branches.  The git trees are public, as is our stable patch queue.  So
if anyone wants to maintain older kernels, it is quite easy to start the
process.

thanks,

greg k-h
