Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964900AbWFSVYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbWFSVYx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 17:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbWFSVYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 17:24:53 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:18392 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964900AbWFSVYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 17:24:52 -0400
Subject: Re: sound skips on 2.6.16.17
From: Lee Revell <rlrevell@joe-job.com>
To: ocilent1@gmail.com
Cc: Chris Wedgwood <cw@f00f.org>, Con Kolivas <kernel@kolivas.org>,
       ck@vds.kolivas.org, Hugo Vanwoerkom <rociobarroso@att.net.mx>,
       linux list <linux-kernel@vger.kernel.org>
In-Reply-To: <200606191154.33747.ocilent1@gmail.com>
References: <4487F942.3030601@att.net.mx>
	 <200606181204.29626.ocilent1@gmail.com>
	 <20060618044047.GA1261@tuatara.stupidest.org>
	 <200606191154.33747.ocilent1@gmail.com>
Content-Type: text/plain
Date: Mon, 19 Jun 2006 17:24:40 -0400
Message-Id: <1150752280.2754.38.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-19 at 11:54 +0800, ocilent1 wrote:
> On Sunday 18 June 2006 12:40, Chris Wedgwood wrote:
> > On Sun, Jun 18, 2006 at 12:04:29PM +0800, ocilent1 wrote:
> > > (PCI-quirk-VIA-IRQ-fixup-should-only-run-for-VIA-southbridges.patch)
> > > that is causing the sound stuttering/skipping problems for our users
> > > with VIA chipsets. Backing out the first patch alone did not fix the
> > > problem (PCI-VIA-quirk-fixup-additional-PCI-IDs.patch) but to back
> > > out the 2nd patch, you need to have initially backed out the first
> > > patch, due to the way the patches apply in series.
> >
> > what mainboard/CPU do you have there?
> >
> > what does 'lspci -n' say?
> 
> It is a compaq presario with KM266 mobo AMD XP2200+
> 

Here is lspci -n output from another user on the ALSA lists who is
afflicted by this bug:

00:00.0 Class 0600: 1106:0204
00:00.1 Class 0600: 1106:1204
00:00.2 Class 0600: 1106:2204
00:00.3 Class 0600: 1106:3204
00:00.4 Class 0600: 1106:4204
00:00.7 Class 0600: 1106:7204
00:01.0 Class 0604: 1106:b188
00:0a.0 Class 0200: 10ec:8139 (rev 10)
00:0f.0 Class 0101: 1106:0571 (rev 06)
00:10.0 Class 0c03: 1106:3038 (rev 81)
00:10.1 Class 0c03: 1106:3038 (rev 81)
00:10.2 Class 0c03: 1106:3038 (rev 81)
00:10.3 Class 0c03: 1106:3038 (rev 81)
00:10.4 Class 0c03: 1106:3104 (rev 86)
00:11.0 Class 0601: 1106:3227
00:11.5 Class 0401: 1106:3059 (rev 60)
00:18.0 Class 0600: 1022:1100
00:18.1 Class 0600: 1022:1101
00:18.2 Class 0600: 1022:1102
00:18.3 Class 0600: 1022:1103
01:00.0 Class 0300: 1002:4151
01:00.1 Class 0380: 1002:4171

Is it likely to be fixed in 2.6.17.1?

Lee

