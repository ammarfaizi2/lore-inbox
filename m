Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbVKVGeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbVKVGeo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 01:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbVKVGen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 01:34:43 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:25221
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932135AbVKVGen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 01:34:43 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: what is our answer to ZFS?
Date: Tue, 22 Nov 2005 00:34:34 -0600
User-Agent: KMail/1.8
Cc: Tarkan Erimer <tarkane@gmail.com>, linux-kernel@vger.kernel.org,
       Diego Calleja <diegocg@gmail.com>
References: <11b141710511210144h666d2edfi@mail.gmail.com> <200511211252.04217.rob@landley.net> <20051122004531.GA15189@elf.ucw.cz>
In-Reply-To: <20051122004531.GA15189@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511220034.34266.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 November 2005 18:45, Pavel Machek wrote:
> Hi!
> > Sun is proposing it can predict what storage layout will be efficient for
> > as yet unheard of quantities of data, with unknown access patterns, at
> > least a couple decades from now.  It's also proposing that data
> > compression and checksumming are the filesystem's job.  Hands up anybody
> > who spots conflicting trends here already?  Who thinks the 128 bit
> > requirement came from marketing rather than the engineers?
>
> Actually, if you are storing information in single protons, I'd say
> you _need_ checksumming :-).

You need error correcting codes at the media level.  A molecular storage 
system like this would probably look a lot more like flash or dram than it 
would magnetic media.  (For one thing, I/O bandwidth and seek times become a 
serious bottleneck with high density single point of access systems.)

> [I actually agree with Sun here, not trusting disk is good idea. At
> least you know kernel panic/oops/etc can't be caused by bit corruption on
> the disk.]

But who said the filesystem was the right level to do this at?

Rob
