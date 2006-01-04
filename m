Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751690AbWADLNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbWADLNb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 06:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWADLNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 06:13:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27789 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751244AbWADLNa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 06:13:30 -0500
Date: Wed, 4 Jan 2006 03:13:00 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com,
       linux-sound@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Message-Id: <20060104031300.270541d9.zaitcev@redhat.com>
In-Reply-To: <mailman.1136300646.6679.linux-kernel2news@redhat.com>
References: <20050726150837.GT3160@stusta.de>
	<200601031347.19328.s0348365@sms.ed.ac.uk>
	<200601031452.10855.ak@suse.de>
	<mailman.1136300646.6679.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jan 2006 14:01:40 +0000, Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:

> Is multiple-source mixing really a "high end" requirement? When I last 
> checked, the OSS driver didn't support multiple applications claiming it at 
> once, thus requiring you to use "more bloat" like esound, arts, or some other 
> crap to access your soundcard more than once at any given time.

If ALSA's OSS emulator does not support mixing properly, it's a bug
in ALSA, clearly, because real OSS in 2.4 allowed for mixing, as long
as the hardware supported it. I played Doom while listening to MP3s on
ymfpci (which, in fact, was a copy of ALSA's ymfpci with OSS API on top).

If ALSA developers wanted, they could have supported mixing in their OSS
emulator. They intentionally chose not to, in order to create an incentive
for developers to program in native ALSA.

-- Pete
