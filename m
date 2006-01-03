Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964949AbWACVkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964949AbWACVkX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbWACVkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:40:22 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:14346 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S964948AbWACVkV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:40:21 -0500
Date: Tue, 3 Jan 2006 22:40:18 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Tomasz Torcz <zdzichu@irc.pl>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Andi Kleen <ak@suse.de>, perex@suse.cz, alsa-devel@alsa-project.org,
       James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
       linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
       parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       zaitcev@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Message-ID: <20060103214018.GA41446@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Adrian Bunk <bunk@stusta.de>,
	Alistair John Strachan <s0348365@sms.ed.ac.uk>,
	Tomasz Torcz <zdzichu@irc.pl>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
	perex@suse.cz, alsa-devel@alsa-project.org,
	James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
	linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
	parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
	Thorsten Knabe <linux@thorsten-knabe.de>,
	zwane@commfireservices.com, zaitcev@yahoo.com,
	linux-kernel@vger.kernel.org
References: <20050726150837.GT3160@stusta.de> <200601031629.21765.s0348365@sms.ed.ac.uk> <20060103170316.GA12249@dspnet.fr.eu.org> <200601031716.13409.s0348365@sms.ed.ac.uk> <20060103192449.GA26030@dspnet.fr.eu.org> <20060103193736.GG3831@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060103193736.GG3831@stusta.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2006 at 08:37:36PM +0100, Adrian Bunk wrote:
> The udev breakages might not have been nice, but OSS/ALSA is a 
> completely different issue:
> 
> OSS has been deprecated since ALSA was merged into the Linux kernel 
> _four years ago_.

OSS _drivers_ yes, OSS _api_ no.


> And I'm only talking about removing drivers _with ALSA drivers for the 
> same hardware available_.

Sure, and I have no problem with that.  OTOH you'll notice that this
particular subthread was specifically about the OSS api, not the
drivers.


> For a general OSS<->ALSA discussion, you are five years too late.

I couldn't predict 5 years ago that the ALSA API quality would be
somewhat lacking.

  OG.
