Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262314AbTJSWS4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 18:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbTJSWS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 18:18:56 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:34780
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262314AbTJSWSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 18:18:55 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Michael Buesch <mbuesch@freenet.de>, Nick Piggin <piggin@cyberone.com.au>
Subject: Re: Where's the bzip2 compressed linux-kernel patch?
Date: Sun, 19 Oct 2003 17:15:44 -0500
User-Agent: KMail/1.5
Cc: Daniel Egger <degger@fhm.edu>, linux-kernel@vger.kernel.org
References: <200310180018.21818.rob@landley.net> <3F91E01C.4090507@cyberone.com.au> <200310191245.55961.mbuesch@freenet.de>
In-Reply-To: <200310191245.55961.mbuesch@freenet.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310191715.44347.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 19 October 2003 05:45, Michael Buesch wrote:
> On Sunday 19 October 2003 02:51, Nick Piggin wrote:
> > Daniel Egger wrote:
> > >I quick test with a PowerPC kernel and the normal vmlinux image reveals
> > >that this is nonsense.
> > >
> > >-rwxr-xr-x    1 root     root      2766490 2003-09-27 22:29 vmlinux
> > >-rwxr-xr-x    1 root     root      1149410 2003-09-27 22:29 vmlinux.gz
> > >-rwxr-xr-x    1 root     root      1062999 2003-09-27 22:29 vmlinux.bz2
> > >
> > >This is a 86411 bytes or 8.1% reduction, seems significant to me...
> >
> > Sure, it might be worth it in some cases. I didn't mean improvement
> > wasn't measurable at all.
>
> What about making it configurable? If someone want's bzip2
> and if he want's to wait longer to boot, (s)he may
> compile bzip2 support.
> If someone dislikes it, (s)he may use gzip.

That's what the patch against 2.4 did.  I'm banging on a 2.6 version, but 
Manuel's continuing to optimize bunzip over in busybox cvs (I'm good at 
cleaning up and simplifying, but he's way better at optimizing), and I'm 
waiting ot see the results (and starting a micro-version of the compression 
side code in the meantime, which is irrelevant here...)

Rob
