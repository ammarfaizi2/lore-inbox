Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422643AbWAMMcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422643AbWAMMcS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 07:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422644AbWAMMcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 07:32:18 -0500
Received: from mtaout1.012.net.il ([84.95.2.1]:17559 "EHLO mtaout1.012.net.il")
	by vger.kernel.org with ESMTP id S1422643AbWAMMcS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 07:32:18 -0500
Date: Fri, 13 Jan 2006 14:32:15 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: [PATCH] Prevent trident driver from grabbing pcnet32 hardware
In-reply-to: <20060113122358.GH29663@stusta.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Lee Revell <rlrevell@joe-job.com>, Jon Mason <jdmason@us.ibm.com>,
       Jiri Slaby <slaby@liberouter.org>, linux-kernel@vger.kernel.org
Message-id: <20060113123215.GQ5399@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <20060112175051.GA17539@us.ibm.com>
 <43C6ADDE.5060904@liberouter.org> <20060112200735.GD5399@granada.merseine.nu>
 <20060112214719.GE17539@us.ibm.com> <20060112220039.GX29663@stusta.de>
 <1137105731.2370.94.camel@mindpipe>
 <20060113113756.GL5399@granada.merseine.nu> <20060113122358.GH29663@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2006 at 01:23:58PM +0100, Adrian Bunk wrote:

> In my experience with scheduling OSS drivers for removal, users simply 
> use the OSS drivers unless you tell them very explicitely that the OSS 
> driver will go.

If the OSS drivers satisfy them, what's wrong with it?

> It shouldn't be too hard to port the support to ALSA if someone with the  
> hardware is willing to test patches.

Unfortunately, I have a different trident variant (the 5451).

> The goal is to get people still using OSS drivers where ALSA drivers 
> support the same hardware to use the ALSA drivers - and if there were 
> bugs in the ALSA drivers preventing them to switch to ALSA, to report 
> them to the ALSA bug tracking system.
> 
> This has the following advantages:
> - better ALSA drivers

This one is fine.

> - get rid of some unmaintained code in the kernel

This one is irrelevant for trident - I maintain it.

Cheers,
Muli
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

