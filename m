Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262016AbUKDA2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbUKDA2j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 19:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262018AbUKDAYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 19:24:37 -0500
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:63582 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262015AbUKDAYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 19:24:07 -0500
From: Blaisorblade <blaisorblade_spam@yahoo.it>
To: Chris Wedgwood <cw@f00f.org>
Subject: Re: [uml-devel] [PATCH] UML: Use PTRACE_KILL instead of SIGKILL to kill host-OS processes (take #2)
Date: Thu, 4 Nov 2004 01:23:48 +0100
User-Agent: KMail/1.7.1
Cc: Gerd Knorr <kraxel@bytesex.org>,
       user-mode-linux-devel@lists.sourceforge.net,
       Jeff Dike <jdike@addtoit.com>, Anton Altaparmakov <aia21@cam.ac.uk>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
References: <20041103113736.GA23041@taniwha.stupidest.org> <20041103201836.GB29289@bytesex> <20041103204812.GA11010@taniwha.stupidest.org>
In-Reply-To: <20041103204812.GA11010@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411040123.49624.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 November 2004 21:48, Chris Wedgwood wrote:
> On Wed, Nov 03, 2004 at 09:18:36PM +0100, Gerd Knorr wrote:
> > Not sure whenever tt is fixed with my patch, I've tested skas only
> > (I'm building skas-only dynamically linked kernels these days
> > because due to working on x11 framebuffer stuff which needs
> > dynamically linked libX11).

> it would be nice to find a way to make this work TT mode for you

> > So if Chris actually tested TT then his patch probably is ok and
> > needed as well ...

> i'm only using TT mode at present, i don't check esoteric modes that
> require host-OS patches at present
SKAS mode is currently more used and tested than TT mode. And the SKAS patch 
is included at least in WOLK, the SuSE kernel, and the -cko patchset (Con 
Kolivas Overloaded).

That said, feel free not to use it, but at least test that it compiles in SKAS 
mode.

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
