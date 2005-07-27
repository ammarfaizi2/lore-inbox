Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262233AbVG0SpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262233AbVG0SpG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 14:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbVG0Sna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 14:43:30 -0400
Received: from fattire.cabal.ca ([134.117.69.58]:19686 "EHLO fattire.cabal.ca")
	by vger.kernel.org with ESMTP id S261688AbVG0Slz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 14:41:55 -0400
X-IMAP-Sender: kyle
Date: Wed, 27 Jul 2005 14:39:42 -0400
X-OfflineIMAP-x1557433837-52656d6f746546617454697265-494e424f582e4f7574626f78: 1122489653-0363205534345-v4.0.10
From: Kyle McMartin <kyle@parisc-linux.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, perex@suse.cz, alsa-devel@alsa-project.org,
       James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
       linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
       parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       zaitcev@yahoo.com
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Message-ID: <20050727183942.GA2964@roadwarrior.mcmartin.ca>
References: <20050726150837.GT3160@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050726150837.GT3160@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2005 at 05:08:37PM +0200, Adrian Bunk wrote:
> This patch schedules obsolete OSS drivers (with ALSA drivers that 
> support the same hardware) for removal.

oss/harmony.c can probably go, unless someone from parisc-linux
objects. I've written a (working) replacement[1] for oss/ad1889.c
which is in our cvs, and will go upstream shortly. oss/ad1889.c
doesn't (and hasn't ever) worked, so it should probably be removed.

Stuart, Randolph, comments?

1. http://cvs.parisc-linux.org/linux-2.6/sound/pci/ad1889.c?rev=1.30&view=markup

Cheers,
-- 
Kyle McMartin
