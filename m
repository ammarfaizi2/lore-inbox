Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933835AbWLFP0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933835AbWLFP0F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 10:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935436AbWLFP0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 10:26:04 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:45164 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933835AbWLFPZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 10:25:58 -0500
Date: Wed, 6 Dec 2006 15:25:54 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
       Alessandro Guido <alessandro.guido@gmail.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, linux-acpi@vger.kernel.org,
       len.brown@intel.com
Subject: Re: [PATCH] acpi: add backlight support to the sony_acpi driver (v2)
In-Reply-To: <20061202162352.GD4773@ucw.cz>
Message-ID: <Pine.LNX.4.64.0612061525140.28745@pentafluge.infradead.org>
References: <20061127174328.30e8856e.alessandro.guido@gmail.com>
 <20061201133520.GC4239@ucw.cz> <20061201194337.GA7773@khazad-dum.debian.net>
 <20061202162352.GD4773@ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Its nice to see acpi moving to the backlight api. Will acpi also move to 
hwmon and led class support ?

On Sat, 2 Dec 2006, Pavel Machek wrote:

> Hi!
> 
> > > Looks okay to me. We really want unified interface for backlight.
> > 
> > Then I request some help to get
> > http://article.gmane.org/gmane.linux.acpi.devel/19792
> > merged.
> > 
> > Without it, the backlight interface becomes annoying on laptops.  Your
> > screen will be powered off when you remove the modules providing the
> > backlight interface.  This is not consistent with the needs of laptop
> > backlight devices, or with the behaviour the drivers had before the
> > backlight sysfs support was added.
> 
> Just retransmit it to akpm and list, and add acked-by headers with
> people who said patch is okay... that included me IIRC.
> 
> 
