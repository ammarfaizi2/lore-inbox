Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbUDGXwe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 19:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbUDGXwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 19:52:34 -0400
Received: from main.gmane.org ([80.91.224.249]:45785 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261262AbUDGXwd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 19:52:33 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joshua Kwan <joshk@triplehelix.org>
Subject: Re: [2.4] bttv and sparc64
Date: Wed, 07 Apr 2004 16:52:29 -0700
Message-ID: <pan.2004.04.07.23.52.28.330544@triplehelix.org>
References: <pan.2004.04.06.23.39.42.565881@triplehelix.org> <873c7gl0rv.fsf@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-68-126-186-145.dsl.pltn13.pacbell.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Apr 2004 09:12:20 +0200, Gerd Knorr wrote:

> Joshua Kwan <joshk@triplehelix.org> writes:
> 
>> Many modules on sparc64 seem to require I2C support to
>> compile correctly. Why do they not depend on CONFIG_I2C?
> 
> In my source tree bttv (correctly) depends on CONFIG_I2C_ALGOBIT ...
> 
> eskarina kraxel ~# grep BT848 /work/bk/2.4/linux-2.4.23/drivers/media/video/Config.in
> dep_tristate '  BT848 Video For Linux' CONFIG_VIDEO_BT848 $CONFIG_VIDEO_DEV $CONFIG_PCI $CONFIG_I2C_ALGOBIT $CONFIG_SOUND

This is true, but none of the options below CONFIG_I2C are visible to
sparc64 at all. (It's a broken dep, at least as far as I can see. I can't
find anything in the menuconfig system for ARCH=sparc64 about I2C.)

Clue me in, anyone?

-- 
Joshua Kwan


