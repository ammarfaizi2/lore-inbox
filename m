Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbWC2Hge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWC2Hge (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 02:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWC2Hge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 02:36:34 -0500
Received: from webmailv3.ispgateway.de ([80.67.16.113]:14503 "EHLO
	webmailv3.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751133AbWC2Hgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 02:36:33 -0500
Message-ID: <1143617782.442a38f61b98b@www.domainfactory-webmail.de>
Date: Wed, 29 Mar 2006 09:36:22 +0200
From: Clemens Ladisch <clemens@ladisch.de>
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.16-mm2] Kconfig SND_SEQUENCER_OSS help text fix
References: <20060328003508.2b79c050.akpm@osdl.org> <20060328134654.GA9671@silenus.home.res>
In-Reply-To: <20060328134654.GA9671@silenus.home.res>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.8
X-Originating-IP: 213.238.46.206
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frederik Deweerdt wrote:
> The SND_SEQUENCER_OSS config option in sound/core/Kconfig claims it
> could be compiled as a module despite being a bool. This patch
> removes the misleading help text.

The help test is misleading, but partly true.

> - To compile this driver as a module, choose M here: the module
> - will be called snd-seq-oss.

It is not possible to choose M here, but the OSS sequencer will be a
module when the ALSA sequencer (CONFIG_SND_SEQUENCER) is a module.


HTH
Clemens

