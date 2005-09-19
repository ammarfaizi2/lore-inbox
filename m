Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbVISHP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbVISHP3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 03:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbVISHP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 03:15:29 -0400
Received: from krusty.dt.E-Technik.uni-dortmund.de ([129.217.163.1]:47291 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S932347AbVISHP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 03:15:28 -0400
Date: Mon, 19 Sep 2005 09:15:21 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Why don't we separate menuconfig from the kernel?
Message-ID: <20050919071521.GB14601@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <m364szk426.fsf@defiant.localdomain> <9a874849050917174635768d04@mail.gmail.com> <m3d5n7kwwz.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3d5n7kwwz.fsf@defiant.localdomain>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Sep 2005, Krzysztof Halasa wrote:

> > menuconfig is just a little bit of the kbuild system which also
> > includes xconfig, config, gconfig, oldconfig, etc.  menuconfig is just
> > a dialog based frontend to the kbuild system which consists of
> > configuration options, help texts, dependency info etc.
> 
> Sure, that's what I mean. It's used for configuring the kernel, but
> other packages use it (well, some version) too. Example: busybox.

One of Linux's main problems is that all daemons that drive kernel core
functionality are cluttered over various separate projects. While this
allows for independent development, it's annoying if you need to hunt
down the various daemons (udev, autofs, hotplug, iproute, to name the
first that come to mind) only to find out the new version doesn't suit
your distro. I'd rather wish there was a standard kernel "daemons"
package.

> There is no much point in keeping more than one copy. They are

Why should other projects that recycle kernel code impact how the kernel
itself is made.

-- 
Matthias Andree
