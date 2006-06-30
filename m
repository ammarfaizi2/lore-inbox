Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932672AbWF3QNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932672AbWF3QNH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 12:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWF3QNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 12:13:07 -0400
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:34575 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id S1751799AbWF3QNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 12:13:05 -0400
Message-ID: <44A54D8E.3000002@superbug.co.uk>
Date: Fri, 30 Jun 2006 17:13:02 +0100
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, perex@suse.cz,
       Olaf Hering <olh@suse.de>
Subject: Re: [Alsa-devel] OSS driver removal, 2nd round
References: <20060629192128.GE19712@stusta.de>
In-Reply-To: <20060629192128.GE19712@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> Now that I've sent the first round of actually removing the code for OSS 
> drivers where ALSA drivers without regressions exist for the same 
> hardware, it's time for a second round amongst the remaining drivers.
>
>
> SOUND_EMU10K1
> - ALSA #1735 (OSS emulation 4-channel mode rear channels not working)
> - ALSA #1782 (really poor sound with my SB Live 1024 and ALSA)
>   

As the MAINTAINER of EMU10K1, I am happy for EMU10K1 driver to be 
removed from the kernel.

ALSA #1735 is now closed. All the apps the user was trying also support 
ALSA natively now, so OSS is not needed.
ALSA #1782 requires more information from the user. I am expecting this 
to be a configuration problem, and not a driver problem.

