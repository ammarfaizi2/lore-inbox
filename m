Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbTI2V3d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 17:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263054AbTI2V3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 17:29:33 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:18369 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262731AbTI2V3b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 17:29:31 -0400
Date: Mon, 29 Sep 2003 23:29:25 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Karol Kozimor <sziwan@hell.org.pl>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PM][INPUT] keyboard dead after resuming from S3
Message-ID: <20030929212925.GA19916@ucw.cz>
References: <20030929211344.GC12894@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030929211344.GC12894@hell.org.pl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 11:13:44PM +0200, Karol Kozimor wrote:

> As far as I remember, my keyboard (a standard laptop AT keyboard) never
> worked after resuming from S3. In older kernels, I was able to get away
> with this by reloading atkbd.ko. However, for newer ones (2.6.0-test5-mm4,
> specifically), I can't do that, as the following appears:
> 
> atkbd: Unknown symbol dump_i8042_history
> 
> A similar warning is issued at depmod stage.

You probably have the atkbd module from a different kernel version.
Rebuild your atkbd module.

> How are your plans to add suspend / resume support to the serio core (I
> thought I saw some Synaptics patches a while ago)?

Yes, I'm working on that.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
