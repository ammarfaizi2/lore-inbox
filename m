Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbWACSYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbWACSYo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 13:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbWACSYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 13:24:44 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:37785 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932420AbWACSYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 13:24:43 -0500
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
From: Lee Revell <rlrevell@joe-job.com>
To: Andi Kleen <ak@suse.de>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Adrian Bunk <bunk@stusta.de>, perex@suse.cz,
       alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <200601031452.10855.ak@suse.de>
References: <20050726150837.GT3160@stusta.de>
	 <p7364p1jvkx.fsf@verdi.suse.de> <200601031347.19328.s0348365@sms.ed.ac.uk>
	 <200601031452.10855.ak@suse.de>
Content-Type: text/plain
Date: Tue, 03 Jan 2006 13:24:37 -0500
Message-Id: <1136312678.24703.56.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-03 at 14:52 +0100, Andi Kleen wrote:
> On Tuesday 03 January 2006 14:47, Alistair John Strachan wrote:
> 
> > It strikes me that it's a bit of a chicken and egg problem. Vendors are still 
> > releasing applications on Linux that support only OSS, partly due to 
> > ignorance, but mostly because ALSA's OSS compatibility layer allows them to 
> > lazily ignore the ALSA API and target all cards, old and new.
> 
> As long as it works why is that a bad thing? OSS API works just fine
> for most sound needs. If you want to do high end sound you can still
> use ALSA.

OSS can't do software mixing of multiple audio streams, it requires a
sound server to do this.  So IMHO the OSS approach causes more bloat on
the desktop.

Lee

