Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWCDBeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWCDBeN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 20:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWCDBeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 20:34:13 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:63395 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932144AbWCDBeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 20:34:12 -0500
From: Grant Coady <gcoady@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc5-mm2
Date: Sat, 04 Mar 2006 12:34:04 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <33rh02d65h18t6fo9j3reoaovd8kekjd88@4ax.com>
References: <20060303045651.1f3b55ec.akpm@osdl.org>
In-Reply-To: <20060303045651.1f3b55ec.akpm@osdl.org>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Mar 2006 04:56:51 -0800, Andrew Morton <akpm@osdl.org> wrote:

>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm2/

make oldconfig: some new options should default to 'N'?

Examples:
Sony Laptop Extras (ACPI_SONY) [M/n/y/?] (NEW)

Enable firmware EDID (FB_FIRMWARE_EDID) [Y/n/?] (NEW)

Alsa:
Why do I want these by default?
OSS PCM (digital audio) API - Include plugin system (SND_PCM_OSS_PLUGINS) [Y/n/?] (NEW)
Verbose procfs contents (SND_VERBOSE_PROCFS) [Y/n/?] (NEW)

RTC class (RTC_CLASS) [Y/n/m/?] (NEW) ?

I used a .config from 2.6.16-rc4 then make oldconfig.  In general I'd 
expect new features to default off.  There's others too, but I'd have 
to start from scratch to fins them all.  Not in summer time ;)

Grant.
