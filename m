Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272247AbTHEBYE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 21:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272318AbTHEBYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 21:24:04 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:45816 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S272247AbTHEBYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 21:24:02 -0400
Date: Mon, 4 Aug 2003 21:18:20 -0400
From: Andrew Pimlott <andrew@pimlott.net>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: aia21@cam.ac.uk, aebr@win.tue.nl, linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
Message-ID: <20030805011820.GB23512@pimlott.net>
Mail-Followup-To: Stephan von Krawczynski <skraw@ithnet.com>,
	aia21@cam.ac.uk, aebr@win.tue.nl, linux-kernel@vger.kernel.org
References: <20030804141548.5060b9db.skraw@ithnet.com> <20030804134415.GA4454@win.tue.nl> <20030804155604.2cdb96e7.skraw@ithnet.com> <Pine.SOL.4.56.0308041458500.22102@orange.csi.cam.ac.uk> <20030804165002.791aae3d.skraw@ithnet.com> <20030804225819.GA23512@pimlott.net> <20030805021938.7e547cce.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030805021938.7e547cce.skraw@ithnet.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 02:19:38AM +0200, Stephan von Krawczynski wrote:
> On Mon, 4 Aug 2003 18:58:19 -0400
> Andrew Pimlott <andrew@pimlott.net> wrote:
> > 
> > In preparing this example, I discovered that find and ls -R already
> > have hard-link cycle "protection" built in, so they are broken in
> > the presence of bind mounts.  :-(
> 
> Ok, so now we are at: application programmer expected hardlinks to exist, but
> fs programmer says they won't because they break existing applications.

I would say that a few venerable programs, that have seen wide use
on old broken versions of unix, contain workarounds for this
problem.  I'm sure that most applications don't contain such
workarounds.  And it is expensive, so I would certainly prefer that
my find and ls didn't do this.

> Now the discussion gets real interesting ;-)

Wouldn't bind mounts solve your problem?  Why are you still
interested in hard links?

Andrew
