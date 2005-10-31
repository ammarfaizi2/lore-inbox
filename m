Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbVJaHJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbVJaHJz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 02:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbVJaHJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 02:09:55 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:2466 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932276AbVJaHJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 02:09:54 -0500
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
From: Lee Revell <rlrevell@joe-job.com>
To: Andi Kleen <ak@suse.de>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <p73mzkqubf4.fsf@verdi.suse.de>
References: <20051030105118.GW4180@stusta.de>
	 <p73mzkqubf4.fsf@verdi.suse.de>
Content-Type: text/plain
Date: Mon, 31 Oct 2005 02:06:31 -0500
Message-Id: <1130742392.32101.16.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-10-30 at 19:06 +0100, Andi Kleen wrote:
> Adrian Bunk <bunk@stusta.de> writes:
> 
> > This patch schedules obsolete OSS drivers (with ALSA drivers that support the
> > same hardware) for removal.
> > 
> > Scheduling the via82cxxx driver for removal was ACK'ed by Jeff Garzik.
> 
> I would prefer if the ICH driver be kept. It works just fine on near
> all my systems and has a much smaller binary size than the ALSA
> variant. Moving to ALSA would bloat the kernels considerably.
> 

The emu10k1 ALSA driver is considerably smaller than the OSS driver and
has more features, like most ALSA drivers.  If the ICH driver is really
smaller I suspect it's missing some functionality.

Lee

