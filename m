Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030892AbWI0VoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030892AbWI0VoO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 17:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030902AbWI0VoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 17:44:14 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:17320 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030892AbWI0VoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 17:44:13 -0400
Subject: Re: [PATCH] Chipset addition for the VIA Southbridge workaround /
	quirk
From: Lee Revell <rlrevell@joe-job.com>
To: Michiel de Boer <x@rebelhomicide.demon.nl>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <451AE795.6030804@rebelhomicide.demon.nl>
References: <451AE795.6030804@rebelhomicide.demon.nl>
Content-Type: text/plain
Date: Wed, 27 Sep 2006 17:44:46 -0400
Message-Id: <1159393487.1275.52.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-27 at 23:05 +0200, Michiel de Boer wrote:
> Also built in is an Creative Labs SB Live! audio device. When i was
> still using windows 98, i experienced corruptions when burning DVD's,
> and after lengthy investigation i discovered i had a buggy
> southbridge.[1]
> Apparently the presence of the SB Live! audio device might even
> accelerate the problem, although it does not actually disappear when
> this PCI card is removed. When i moved to Linux, i decided that
> writing a kernel patch based on the fixup programs i found for windows
> 98 would be appropriate. 

Just FYI, the onboard "SBLive" is not a real SBLive! - it uses a newer,
cheaper, and vastly inferior chipset that moves all of the interesting
hardware features of the good old SBLive! into the (Windows) driver. 

I would be surprised if it had the same issues as the original emu10k1
chipset, which generated a lot more bus traffic by implementing multiple
stream mixing in hardware.

IOW, this bug is probably unrelated to the SBLive...

Lee

