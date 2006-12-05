Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967873AbWLEAPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967873AbWLEAPV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 19:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967877AbWLEAPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 19:15:21 -0500
Received: from ellpspace.math.ualberta.ca ([129.128.207.67]:36433 "EHLO
	ellpspace.math.ualberta.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S967873AbWLEAPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 19:15:20 -0500
Date: Mon, 4 Dec 2006 17:15:18 -0700
From: Michal Jaegermann <michal@ellpspace.math.ualberta.ca>
To: Tobias Oed <tobiasoed@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: why can't I remove a kernel module (or: what uses a given module)?
Message-ID: <20061205001518.GA23127@ellpspace.math.ualberta.ca>
Reply-To: michal@harddata.com
References: <4572B30F.9020605@wpkg.org> <jewt592oxf.fsf@sykes.suse.de> <4572BBE0.4010801@wpkg.org> <20061203154936.GB26669@kallisti.us> <45732C8E.4060801@wpkg.org> <el0s6r$agu$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <el0s6r$agu$1@sea.gmane.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2006 at 11:10:01AM +0100, Tobias Oed wrote:
> Tomasz Chmielewski wrote:
> 
> > Yes, something's using that drive, be it a program, a module (unlikely),
> > or something that is compiled directly in the kernel (for example,
> > md/raid1).
> 
> Since you mention md, dm comes to mind. I have seen a couple of drives that
> were previously attached to fake raid controllers becoming unavailable when
> moved to a normal controller. I haven't found the one size workaround for
> the problem yet.

     dmraid -r -E <device_in_question>

Yes, I was hit by this in a different context.  A command is
described on 'man dmraid' but figuring out what was the issue
took me a long while.

   Michal
