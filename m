Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbVGZR5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbVGZR5n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 13:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbVGZRzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 13:55:23 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:27407 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261962AbVGZRxg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 13:53:36 -0400
Date: Tue, 26 Jul 2005 13:49:33 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, perex@suse.cz,
       alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       zaitcev@yahoo.com
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Message-ID: <20050726174931.GD6974@tuxdriver.com>
Mail-Followup-To: Lee Revell <rlrevell@joe-job.com>,
	Jeff Garzik <jgarzik@pobox.com>, Adrian Bunk <bunk@stusta.de>,
	linux-kernel@vger.kernel.org, perex@suse.cz,
	alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
	sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
	kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
	Thorsten Knabe <linux@thorsten-knabe.de>,
	zwane@commfireservices.com, zaitcev@yahoo.com
References: <20050726150837.GT3160@stusta.de> <42E65B34.9080700@pobox.com> <1122396587.18884.34.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122396587.18884.34.camel@mindpipe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2005 at 12:49:46PM -0400, Lee Revell wrote:
> On Tue, 2005-07-26 at 11:48 -0400, Jeff Garzik wrote:
> > NAK for i810_audio:  ALSA doesn't have all the PCI IDs (which must be 
> > verified -- you cannot just add the PCI IDs for some hardware)
> 
> Some of them might be in snd-hda-intel in addition to snd-intel8x0.

Hmmm...I don't think that would work.  If there are IDs listed in
both i810_audio and snd-hda-intel, it is probably a mistake.

John
-- 
John W. Linville
linville@tuxdriver.com
