Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160996AbWF0TLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160996AbWF0TLg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 15:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbWF0TLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 15:11:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:49298 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932254AbWF0TLe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 15:11:34 -0400
Date: Tue, 27 Jun 2006 15:11:25 -0400
From: Dave Jones <davej@redhat.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-git broke suspend!
Message-ID: <20060627191125.GH7914@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Jens Axboe <axboe@suse.de>,
	linux-kernel@vger.kernel.org
References: <20060627181045.GA32115@suse.de> <20060627182014.GB7914@redhat.com> <20060627182646.GB32115@suse.de> <20060627183935.GC7914@redhat.com> <20060627185532.GD32115@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060627185532.GD32115@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 08:55:33PM +0200, Jens Axboe wrote:

 > > I don't see any cpufreq stuff in your dmesg at all. 
 > > Is it definitly on in the config ?
 > 
 > Strangely, now /sys/devices/system/cpu/cpu0 also seems to be empty on
 > this kernel. Wonder what is going on here...
 > 
 > CONFIG_CPU_FREQ=y
 > CONFIG_CPU_FREQ_TABLE=y
 > # CONFIG_CPU_FREQ_DEBUG is not set
 > CONFIG_CPU_FREQ_STAT=y
 > # CONFIG_CPU_FREQ_STAT_DETAILS is not set
 > CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
 > # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
 > CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
 > CONFIG_CPU_FREQ_GOV_POWERSAVE=m
 > CONFIG_CPU_FREQ_GOV_USERSPACE=m
 > CONFIG_CPU_FREQ_GOV_ONDEMAND=m
 > CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m

CONFIG_X86_SPEEDSTEP_CENTRINO too ?

booting with cpufreq.debug=7 should show _some_ info.
Give that a shot

		Dave

-- 
http://www.codemonkey.org.uk
