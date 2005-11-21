Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750937AbVKUAPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbVKUAPu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 19:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbVKUAPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 19:15:50 -0500
Received: from allen.werkleitz.de ([80.190.251.108]:35201 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S1750871AbVKUAPt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 19:15:49 -0500
Date: Mon, 21 Nov 2005 01:15:48 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Message-ID: <20051121001548.GA6964@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Gene Heskett <gene.heskett@verizon.net>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org> <200511200018.11791.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511200018.11791.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: 84.189.239.172
Subject: Re: Linux 2.6.15-rc2
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2005 Gene Heskett wrote:
> First breakage report, tvtime, blue screen no audio.  Trying slightly
> different .config for next build.

Probably v4l breakage due to VM changes. For me xawtv overlay works,
grabdisplay doesn't (with different cards). This was reported before.

> My tuner (OR51132) seems to be
> permanently selected in an xconfig screen.  Dunno if thats good or bad
> ATM.

Works for me in menuconfig. You probably have
CONFIG_VIDEO_SAA7134_DVB_ALL_FRONTENDS selected?

Johannes

PS: don't trim Cc: on lkml
