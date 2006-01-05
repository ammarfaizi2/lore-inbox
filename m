Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752063AbWAEGjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063AbWAEGjT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 01:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752067AbWAEGjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 01:39:19 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:61893 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1752065AbWAEGjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 01:39:18 -0500
Subject: Re: [2.6 patch] the scheduled removal of obsolete OSS drivers
From: Lee Revell <rlrevell@joe-job.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060103114900.GA3831@stusta.de>
References: <20060103114900.GA3831@stusta.de>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 01:39:14 -0500
Message-Id: <1136443154.24475.2.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-03 at 12:49 +0100, Adrian Bunk wrote:
>  sound/oss/nm256.h                          |  292 
>  sound/oss/nm256_audio.c                    | 1709 -----
>  sound/oss/nm256_coeff.h                    | 4697 ---------------- 

This driver must not be removed.  The ALSA driver is broken.

Here's why:

On Tue, 2006-01-03 at 13:14 +0100, Takashi Iwai wrote: 
> Unfortunately, it's impossible to fix this without a test hardware.
> The condition is worst:  No datasheet, a picky chipset, a pure
> reverse-engineered driver code.
> 
> 
> Takashi
> 

See https://bugtrack.alsa-project.org/alsa-bug/view.php?id=328 for details.

Lee

