Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263491AbTKWWcc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 17:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263497AbTKWWcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 17:32:32 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:1153 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263491AbTKWWcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 17:32:31 -0500
Date: Sun, 23 Nov 2003 17:31:03 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: A E Lawrence <A.E.Lawrence@lboro.ac.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9 oss sound missing symbols
In-Reply-To: <3FC0C9DF.2030700@lboro.ac.uk>
Message-ID: <Pine.LNX.4.53.0311231730470.2498@montezuma.fsmlabs.com>
References: <3FC0C9DF.2030700@lboro.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Nov 2003, A E Lawrence wrote:

> I have a 82C930 based sound card. Under 2.4.22 and earlier kernels, I use
> the old OSS driver. Having failed to identify any support for this chip
> under ALSA, I have configured 2.6.0-test9 with a similar OSS configuration.
> 
> The relevant parts of the .config files are:-
> 
> 2.4.22                  2.6.0-test9
> ------                  -----------
> # Sound                 # CONFIG_SND is not set
> #                       CONFIG_SOUND_PRIME=m
> CONFIG_SOUND=m          CONFIG_SOUND_OSS=y
>                           CONFIG_SOUND_TRACEINIT=y
> CONFIG_SOUND_MPU401=m   CONFIG_SOUND_MPU401=m
> CONFIG_SOUND_MAD16=m    CONFIG_SOUND_MAD16=m
> CONFIG_SOUND_YM3812=m   CONFIG_SOUND_YM3812=m
> 
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Under 2.6.0-test9, there are unresolved symbols:-

Please send your whole .config

Ta,
	Zwane

