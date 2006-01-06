Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751460AbWAKMlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbWAKMlb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 07:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbWAKMla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 07:41:30 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:32005 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751460AbWAKMl2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 07:41:28 -0500
Date: Fri, 6 Jan 2006 20:29:48 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-pm@osdl.org, linux-kernel@vger.kernel.org,
       Jean-Luc Leger <reiga@dspnet.fr.eu.org>
Subject: Re: SOFTWARE_SUSPEND: dependency on non-existing FVR symbol
Message-ID: <20060106202948.GB2736@ucw.cz>
References: <20060110043627.GD3911@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060110043627.GD3911@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-01-06 05:36:27, Adrian Bunk wrote:
> The following issue in kernel/power/Kconfig was noted by
> Jean-Luc Leger <reiga@dspnet.fr.eu.org>:
> 
> config SOFTWARE_SUSPEND
>         bool "Software Suspend"
>         depends on PM && SWAP && (X86 && (!SMP || SUSPEND_SMP)) || ((FVR || PPC32) && !SMP)
> 
> 
> The problem is that there is no FVR symbol in the kernel.
> 
> Is this a misspelling of FRV or something different?

FRV, IIRC, but apparently noone ever tested that.
								Pavel
-- 
Thanks, Sharp!
