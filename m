Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbWFXPiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbWFXPiU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 11:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWFXPiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 11:38:20 -0400
Received: from thunk.org ([69.25.196.29]:28567 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750833AbWFXPiT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 11:38:19 -0400
Date: Sat, 24 Jun 2006 11:38:18 -0400
From: Theodore Tso <tytso@mit.edu>
To: Jeff Dike <jdike@addtoit.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm1: UML failing w/o SKAS enabled
Message-ID: <20060624153818.GB7752@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060621034857.35cfe36f.akpm@osdl.org> <20060622213443.GA22303@thunk.org> <20060623024222.GA8316@ccure.user-mode-linux.org> <20060623210714.GA16661@thunk.org> <20060623214623.GA7319@ccure.user-mode-linux.org> <20060624140001.GA7752@thunk.org> <20060624152235.GB3627@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060624152235.GB3627@ccure.user-mode-linux.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2006 at 11:22:35AM -0400, Jeff Dike wrote:
> I'm working on this - the genirq stuff in -mm broke UML.  Add stderr=1
> to the command line to see the actual crash.  2.6.17 is fine, except
> you need a klibc patch for O= builds.

Yeah, I was using CONFIG_MODE_TT with 2.6.17 to test the inode
slimming patches, mainly because it was a lot easier to test each
patch one at a time, and UML was working just fine for me.  The only
reason I was using TT was because it had always worked before, so I
just carried over the .config file and I didn't know that TT mode was
getting deprecated.  (I was using UML with 2.6.17-mm1 to port the
patches to the -mm tree so they could get wider testing.)

					- Ted
