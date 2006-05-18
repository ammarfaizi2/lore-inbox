Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751403AbWERVkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbWERVkR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 17:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWERVkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 17:40:17 -0400
Received: from math.ut.ee ([193.40.36.2]:48804 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S1751403AbWERVkQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 17:40:16 -0400
Date: Fri, 19 May 2006 00:39:59 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Takashi Iwai <tiwai@suse.de>
cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] Re: How to enable bios-disabled soundcard?
In-Reply-To: <s5h3bf72us4.wl%tiwai@suse.de>
Message-ID: <Pine.SOC.4.61.0605190039160.27206@math.ut.ee>
References: <Pine.SOC.4.61.0605181650080.4469@math.ut.ee>
 <20060518151520.GA32572@rhlx01.fht-esslingen.de> <s5h3bf72us4.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The best way to find out is to edit snd_cs4281_probe() and add snd_printk()s
>> at all error paths to find the one which actually fails.
>
> The error EIO comes only from snd_cs4281_chip_init(), and you must
> have a corresponding error message.
>
> There are some fixes in 2.6.17 tree regarding cs4281.  Give it a try.

Yes! Todays 2.6.17-rc4+git works fine with this soundcard. Thanks!

-- 
Meelis Roos (mroos@linux.ee)
