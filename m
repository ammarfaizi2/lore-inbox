Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264117AbUDGHEc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 03:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264106AbUDGHEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 03:04:32 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:20152 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S264117AbUDGHEG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 03:04:06 -0400
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: [2.4] bttv and sparc64
Date: 07 Apr 2004 09:12:20 +0200
Organization: SuSE Labs, Berlin
Message-ID: <873c7gl0rv.fsf@bytesex.org>
References: <pan.2004.04.06.23.39.42.565881@triplehelix.org>
NNTP-Posting-Host: localhost
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: bytesex.org 1081321940 12084 127.0.0.1 (7 Apr 2004 07:12:20 GMT)
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Kwan <joshk@triplehelix.org> writes:

> Many modules on sparc64 seem to require I2C support to
> compile correctly. Why do they not depend on CONFIG_I2C?

In my source tree bttv (correctly) depends on CONFIG_I2C_ALGOBIT ...

eskarina kraxel ~# grep BT848 /work/bk/2.4/linux-2.4.23/drivers/media/video/Config.in
dep_tristate '  BT848 Video For Linux' CONFIG_VIDEO_BT848 $CONFIG_VIDEO_DEV $CONFIG_PCI $CONFIG_I2C_ALGOBIT $CONFIG_SOUND

  Gerd

-- 
http://bigendian.bytesex.org
