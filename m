Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262000AbUKCX1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbUKCX1w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 18:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbUKCXYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 18:24:50 -0500
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:58460 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261979AbUKCXWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 18:22:07 -0500
From: Blaisorblade <blaisorblade_spam@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH] UML: Use PTRACE_KILL instead of SIGKILL to kill host-OS processes (take #2)
Date: Thu, 4 Nov 2004 00:19:07 +0100
User-Agent: KMail/1.7.1
Cc: Gerd Knorr <kraxel@bytesex.org>, Chris Wedgwood <cw@f00f.org>,
       Jeff Dike <jdike@addtoit.com>, Anton Altaparmakov <aia21@cam.ac.uk>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
References: <20041103113736.GA23041@taniwha.stupidest.org> <200411032028.44376.blaisorblade_spam@yahoo.it> <20041103201836.GB29289@bytesex>
In-Reply-To: <20041103201836.GB29289@bytesex>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411040019.07884.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 November 2004 21:18, Gerd Knorr wrote:
> > I'm going to test this. I thought that Gerd Knorr patch (which I sent
> > cc'ing LKML and most of you) already solved this (I actually modified
> > that one,

> Not sure whenever tt is fixed with my patch, I've tested skas only

I've tested it, and it works in fact.

> (I'm 
> building skas-only dynamically linked kernels these days because due to
> working on x11 framebuffer stuff which needs dynamically linked libX11).
> So if Chris actually tested TT then his patch probably is ok and needed
> as well ...

Actually, from looking at Jeff Dike comment, it seem that the new kill (the 
one you've changed) is executed earlier and more reliably than the 1st one, 
the one Chris identified.

So we could ask Jeff to see if he can remove the earlier kill, the one 
affected by the Chris Wedgwood.


-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
