Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbWBMIkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbWBMIkz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 03:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWBMIky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 03:40:54 -0500
Received: from mail20.bluewin.ch ([195.186.19.65]:52666 "EHLO
	mail20.bluewin.ch") by vger.kernel.org with ESMTP id S1751092AbWBMIky
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 03:40:54 -0500
Date: Mon, 13 Feb 2006 03:36:35 -0500
To: Lee Revell <rlrevell@joe-job.com>
Cc: Adrian Bunk <bunk@stusta.de>, jgarzik@pobox.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] CONFIG_FORCEDETH updates
Message-ID: <20060213083635.GD14516@krypton>
References: <20060212175202.GK30922@stusta.de> <1139781817.19342.300.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1139781817.19342.300.camel@mindpipe>
User-Agent: Mutt/1.5.11
From: apgo@patchbomb.org (Arthur Othieno)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2006 at 05:03:36PM -0500, Lee Revell wrote:
> On Sun, 2006-02-12 at 18:52 +0100, Adrian Bunk wrote:
> > This patch contains the following possible updates:
> > - let FORCEDETH no longer depend on EXPERIMENTAL
> > - remove the "Reverse Engineered" from the option text:
> >   for the user it's important which hardware the driver supports, not
> >   how it was developed
> 
> Is this driver as stable as one that was developed with proper
> documentation?

Been using it on nForce since v0.19 (circa 2003) with no problems.
I doubt there are that many (significant) users of the binary driver
left..

And like Alistair pointed out:

  drivers/net/forcedeth:17: * Copyright (c) 2004 NVIDIA Corporation

> I prefer to know that something as elementary as a fast ethernet
> controller had to be reverse engineered so I can avoid supporting
> a vendor so hostile to Linux.

Then how about moving the "Reverse Engineered" to the help text instead?
