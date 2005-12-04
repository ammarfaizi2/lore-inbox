Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbVLDQni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbVLDQni (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 11:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbVLDQnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 11:43:37 -0500
Received: from isilmar.linta.de ([213.239.214.66]:23991 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S932271AbVLDQnh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 11:43:37 -0500
Date: Sun, 4 Dec 2005 17:43:35 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Dave Jones <davej@redhat.com>, cpufreq <cpufreq@www.linux.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CPU frequency display in /proc/cpuinfo
Message-ID: <20051204164335.GB32492@isilmar.linta.de>
Mail-Followup-To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
	Dave Jones <davej@redhat.com>, cpufreq <cpufreq@www.linux.org.uk>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20051202181927.GD9766@wotan.suse.de> <20051202104320.A5234@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051202104320.A5234@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2005 at 10:43:20AM -0800, Venkatesh Pallipadi wrote:
> The patch below changes this to:
> Show the last known frequency of the particular CPU, when cpufreq is present. If
> cpu doesnot support changing of frequency through cpufreq, then boot frequency 
> will be shown. The patch affects i386, x86_64 and ia64 architectures.

Looks good to me -- however, might this affect userspace cpufreq tools? I'd
vote for quite some time in -mm for this patch (i.e. only merge for 2.6.17)

	Dominik
