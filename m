Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932545AbVL1Wup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932545AbVL1Wup (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 17:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbVL1Wuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 17:50:44 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:62667 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932545AbVL1Wuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 17:50:44 -0500
Subject: Re: [BUG] 2.6.15-rc7 ALSA sound/usb/usbaudio.c:801: cannot submit
	datapipe for urb
From: Lee Revell <rlrevell@joe-job.com>
To: Christian Leber <christian@leber.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051228223742.GA23531@core.home>
References: <20051228223742.GA23531@core.home>
Content-Type: text/plain
Date: Wed, 28 Dec 2005 17:56:07 -0500
Message-Id: <1135810567.7680.8.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-28 at 23:37 +0100, Christian Leber wrote:
> Hello,
> 
> when i try to use my usb soundcard (Terratec Aureon 5.1 USB, old
> version) with 2.6.15-rc7 i get the following error message:
> 
> ALSA sound/usb/usbaudio.c:801: cannot submit datapipe for urb 5, err = -28
> 
> with 2.6.14.4 and older versions it works without problems.

This is an FAQ.

Disable CONFIG_USB_BANDWIDTH and it will work.

Which host controller driver are you using?

Lee

