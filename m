Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265620AbTF2KXY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 06:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265622AbTF2KXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 06:23:23 -0400
Received: from paloma16.e0k.nbg-hannover.de ([62.181.130.16]:29669 "HELO
	paloma16.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id S265620AbTF2KXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 06:23:16 -0400
From: Jan-Hinnerk Reichert <jan-hinnerk_reichert@hamburg.de>
To: Adrian Bunk <bunk@fs.tum.de>
Subject: Re: [2.4.22-pre1] menuconfig oddity
Date: Sun, 29 Jun 2003 12:37:23 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <200306231927.57946.jan-hinnerk_reichert@hamburg.de> <20030626175032.GA24661@fs.tum.de>
In-Reply-To: <20030626175032.GA24661@fs.tum.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306291237.23250.jan-hinnerk_reichert@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 June 2003 19:50, Adrian Bunk wrote:
> On Mon, Jun 23, 2003 at 07:27:57PM +0200, Jan-Hinnerk Reichert wrote:
> > Hi,
> >
> > first I want to say that I could compile 2.4.22-pre1 without problems and
> > everything works fine for 4 hours on a desktop machine with little load.
> >
> > However, I had a small problem during my installation:
> >
> > After the first compilation and reboot, I started menuconfig again and
> > all subentries of "ACPI support" were gone. I took a brief look at the
> > .config, but there were at least some entries.
> >
> > So I ignored this, changed my config via menuconfig, recompiled and
> > rebooted and ACPI was gone ;-(
> >
> > After copying my old config and "make oldconfig", everything was back to
> > normal. Unfortunately i wasn't able to reproduce this error.
> >
> > I just wanted to let you know...
>
> Did you accidentially enable "CPU Enumeration Only" in the
> "ACPI support" menu?

I can't say for sure, but the "CPU Enumeration Only" entry was also gone when 
I noticed the error.
There was only the "ACPI support" entry left in the "ACPI support" menu.

> If this isn't the problem, please send your .config.

Unfortunately, I haven't saved the non-working .config.

Which config should I sent? The old 2.4.20-SuSE, the one after "make 
oldconfig"?

 Jan-Hinnerk

