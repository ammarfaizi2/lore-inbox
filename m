Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751021AbWATO0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbWATO0d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 09:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbWATO0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 09:26:33 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:43183 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751020AbWATO0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 09:26:32 -0500
Date: Fri, 20 Jan 2006 15:25:54 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Peter Zubaj <pzad@pobox.sk>
cc: alsa-devel@lists.sourceforge.net, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
       perex@suse.cz
Subject: Re: [Alsa-devel] RFC: OSS driver removal, a slightly different
 approach
In-Reply-To: <200601191947.20748.pzad@pobox.sk>
Message-ID: <Pine.LNX.4.61.0601201524080.22940@yvahk01.tjqt.qr>
References: <20060119174600.GT19398@stusta.de> <200601191947.20748.pzad@pobox.sk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi,
>
>On Thursday 19 January 2006 18:46, Adrian Bunk wrote:
>> SOUND_EMU10K1
>> - ALSA #1735 (OSS emulation 4-channel mode rear channels not working)
>
>If I understand alsa - oss emulation correctly, I think, this will be not 
>fixed soon (my opinion - never). This is too much work for too little gain.

On that way, I'd like to inquiry something:
I have a card that works with the snd-cs46xx module.
With the OSS emulation (/dev/dsp), I can only output 2 channels, and the 
other two must be sent to /dev/adsp. Is this intended? Would not it be 
easier to make /dev/dsp allow receiving an ioctl setting 4 channels?


Jan Engelhardt
-- 
