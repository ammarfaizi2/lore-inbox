Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbTIRLfQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 07:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbTIRLfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 07:35:16 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:61161 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261157AbTIRLfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 07:35:12 -0400
Date: Tue, 16 Sep 2003 19:33:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Ramon Casellas <casellas@infres.enst.fr>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Bug/Oops Power Management with linux-2.6.0-test5-mm2
Message-ID: <20030916173300.GB8210@openzaurus.ucw.cz>
References: <Pine.LNX.4.33.0309160856390.958-100000@localhost.localdomain> <Pine.SOL.4.40.0309161819150.7029-100000@gervaise.enst.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.40.0309161819150.7029-100000@gervaise.enst.fr>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Suspend to disk does not work (If I don't kill artsd, cf. previous
> message). If I kill artsd first, :
> Stopping tasks:
> ================================================================
> =======|
> Freeing memory: .........................................................|
> hda: start_power_step(step: 0)
> hda: start_power_step(step: 1)
> hda: complete_power_step(step: 1, stat: 50, err: 0)
> hda: completing PM request, suspend
> PM: Attempting to suspend to disk.
> PM: snapshotting memory.
> pmdisk is not supported with high- or discontig-mem.

Turn off highmem and try again.
				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

