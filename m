Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261847AbUKCUnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbUKCUnn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 15:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbUKCUlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 15:41:12 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:45492 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261866AbUKCUkc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 15:40:32 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 3 Nov 2004 21:18:36 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Chris Wedgwood <cw@f00f.org>,
       Jeff Dike <jdike@addtoit.com>, Anton Altaparmakov <aia21@cam.ac.uk>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [uml-devel] [PATCH] UML: Use PTRACE_KILL instead of SIGKILL to kill host-OS processes (take #2)
Message-ID: <20041103201836.GB29289@bytesex>
References: <20041103113736.GA23041@taniwha.stupidest.org> <1099482457.16445.1.camel@imp.csi.cam.ac.uk> <20041103120829.GA23182@taniwha.stupidest.org> <200411032028.44376.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411032028.44376.blaisorblade_spam@yahoo.it>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm going to test this. I thought that Gerd Knorr patch (which I sent cc'ing 
> LKML and most of you) already solved this (I actually modified that one, 

Not sure whenever tt is fixed with my patch, I've tested skas only (I'm
building skas-only dynamically linked kernels these days because due to
working on x11 framebuffer stuff which needs dynamically linked libX11).
So if Chris actually tested TT then his patch probably is ok and needed
as well ...

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)
