Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262215AbVBKILN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbVBKILN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 03:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262216AbVBKILN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 03:11:13 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:33486 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S262215AbVBKILK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 03:11:10 -0500
Date: Fri, 11 Feb 2005 09:11:40 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: InputML <linux-input@atrey.karlin.mff.cuni.cz>,
       alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/10] Convert gameport to driver model/sysfs
Message-ID: <20050211081140.GB1675@ucw.cz>
References: <200502110158.47872.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502110158.47872.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2005 at 01:58:47AM -0500, Dmitry Torokhov wrote:

> This series of patches adds a new "gameport" bus to the driver model.
> It is implemented very similarly to "serio" bus and also allows
> individual drivers to be manually bound/disconnected from a port
> by manipulating port's "drvctl" attribute.

Good work! I'm pulling it into my tree. And test.

> The changes can also be pulled from my tree (which has Vojtech's
> input tree as a parent):
> 
> 	bk pull bk://dtor.bkbits.net/input 
> 
> I am CC-ing ALSA list as the changes touch quite a few sound drivers.
> 
> Comments/testing is appreciated.


-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
