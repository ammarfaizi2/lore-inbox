Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261877AbUKCUzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbUKCUzG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 15:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261883AbUKCUv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 15:51:57 -0500
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:30869 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261876AbUKCUs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 15:48:58 -0500
Date: Wed, 3 Nov 2004 12:48:12 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Blaisorblade <blaisorblade_spam@yahoo.it>,
       user-mode-linux-devel@lists.sourceforge.net,
       Jeff Dike <jdike@addtoit.com>, Anton Altaparmakov <aia21@cam.ac.uk>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [uml-devel] [PATCH] UML: Use PTRACE_KILL instead of SIGKILL to kill host-OS processes (take #2)
Message-ID: <20041103204812.GA11010@taniwha.stupidest.org>
References: <20041103113736.GA23041@taniwha.stupidest.org> <1099482457.16445.1.camel@imp.csi.cam.ac.uk> <20041103120829.GA23182@taniwha.stupidest.org> <200411032028.44376.blaisorblade_spam@yahoo.it> <20041103201836.GB29289@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041103201836.GB29289@bytesex>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 09:18:36PM +0100, Gerd Knorr wrote:

> Not sure whenever tt is fixed with my patch, I've tested skas only
> (I'm building skas-only dynamically linked kernels these days
> because due to working on x11 framebuffer stuff which needs
> dynamically linked libX11).

it would be nice to find a way to make this work TT mode for you

> So if Chris actually tested TT then his patch probably is ok and
> needed as well ...

i'm only using TT mode at present, i don't check esoteric modes that
require host-OS patches at present
