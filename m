Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbTLCT0R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 14:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbTLCT0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 14:26:17 -0500
Received: from havoc.gtf.org ([63.247.75.124]:22190 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261850AbTLCT0Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 14:26:16 -0500
Date: Wed, 3 Dec 2003 14:26:11 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andreas Happe <andreashappe@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test10(-mm1)] 8139too vs. 8139cp
Message-ID: <20031203192611.GA17676@gtf.org>
References: <slrnbssbve.16d.andreashappe@flatline.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <slrnbssbve.16d.andreashappe@flatline.ath.cx>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 03, 2003 at 07:48:14PM +0100, Andreas Happe wrote:
> Hardware in question: HP compaq nx7000 (8139c+ network card), using ACPI
> 
> With the 8139too driver everything works smooth except a "please use
> 8139too for increased performance and stability" message on bootup.
> 
> At first 8139cp works fine, but the machine freezes after 1-2h without
> any accessable oops (I'm running X, there was nothing in the logfiles).
> This happened while audio or video playback (i dunno if it's related,
> eth0, radeon, uhci-hcd, and intel chipset use the same interrupt).

Please try -test11, it should have a fix in 8139cp for this...

	Jeff



