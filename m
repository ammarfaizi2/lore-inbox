Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964955AbWGHSeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955AbWGHSeH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 14:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbWGHSeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 14:34:06 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:40126 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S964955AbWGHSeF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 14:34:05 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Bojan Smojver <bojan@rexursive.com>
Subject: Re: uswsusp history lesson [was Re: [Suspend2-devel] Re: swsusp / suspend2 reliability]
Date: Sat, 8 Jul 2006 20:34:59 +0200
User-Agent: KMail/1.9.3
Cc: Nigel Cunningham <ncunningham@linuxmail.org>, Pavel Machek <pavel@ucw.cz>,
       Avuton Olrich <avuton@gmail.com>, Olivier Galibert <galibert@pobox.com>,
       jan@rychter.com, linux-kernel@vger.kernel.org,
       suspend2-devel@lists.suspend2.net, grundig <grundig@teleline.es>
References: <20060627133321.GB3019@elf.ucw.cz> <200607081238.16753.rjw@sisk.pl> <1152357192.2088.6.camel@beast.rexursive.com>
In-Reply-To: <1152357192.2088.6.camel@beast.rexursive.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607082034.59377.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 July 2006 13:13, Bojan Smojver wrote:
> On Sat, 2006-07-08 at 12:38 +0200, Rafael J. Wysocki wrote:
> 
> > Actually, as I said above, as soon as we are _sure_ that LRU pages are not
> > touched after the memory has been snapshotted, my patch will be mergeable
> > and we'll get the ability to create bigger images without the added
> > complexity.  [Apart from the fact that the whole memory image on a box with
> > more that 512 MB of RAM wouldn't make much sense, IMHO.]  The _only_ thing
> > needed here is an argument which you have to provide anyway to show that
> > suspend2 does the right thing.
> > 
> > As far as the support for ordinary files, swap files, etc. is concerned,
> > there's nothing to worry about.  It's comming.
> 
> This all sounds very encouraging. What's the rough timeframe for this?

Probably a month, but that depends on how much time I will have.

Rafael
