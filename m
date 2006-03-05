Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbWCEG2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWCEG2v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 01:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752008AbWCEG2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 01:28:51 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5296 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751988AbWCEG2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 01:28:50 -0500
Date: Sat, 4 Mar 2006 22:26:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: gcoady@gmail.com
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@suse.cz>,
       Takashi Iwai <tiwai@suse.de>, Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: 2.6.16-rc5-mm2
Message-Id: <20060304222657.0df4f7cc.akpm@osdl.org>
In-Reply-To: <33rh02d65h18t6fo9j3reoaovd8kekjd88@4ax.com>
References: <20060303045651.1f3b55ec.akpm@osdl.org>
	<33rh02d65h18t6fo9j3reoaovd8kekjd88@4ax.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Coady <gcoady@gmail.com> wrote:
>
> On Fri, 3 Mar 2006 04:56:51 -0800, Andrew Morton <akpm@osdl.org> wrote:
> 
> >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm2/
> 
> make oldconfig: some new options should default to 'N'?
> 
> Examples:
> Sony Laptop Extras (ACPI_SONY) [M/n/y/?] (NEW)

That's for mine own convenience.  If you don't like it, buy a Sony ;)

> Enable firmware EDID (FB_FIRMWARE_EDID) [Y/n/?] (NEW)

That's deliberate - previous kernels had this functionality unconditionally
enabled.   We newly provide a way of disabling it.

> Alsa:
> Why do I want these by default?
> OSS PCM (digital audio) API - Include plugin system (SND_PCM_OSS_PLUGINS) [Y/n/?] (NEW)
> Verbose procfs contents (SND_VERBOSE_PROCFS) [Y/n/?] (NEW)

cc's added.

> RTC class (RTC_CLASS) [Y/n/m/?] (NEW) ?

Ditto.

