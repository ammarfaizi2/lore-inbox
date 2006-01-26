Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbWAZOHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWAZOHW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 09:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbWAZOHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 09:07:21 -0500
Received: from mx1.suse.de ([195.135.220.2]:39299 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932317AbWAZOHV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 09:07:21 -0500
Date: Thu, 26 Jan 2006 15:07:19 +0100
From: Olaf Hering <olh@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Zone reclaim: proc override
Message-ID: <20060126140719.GA10099@suse.de>
References: <200601190413.k0J4DjdQ021200@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <200601190413.k0J4DjdQ021200@hera.kernel.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Jan 18, Linux Kernel Mailing List wrote:

> +++ b/kernel/sysctl.c

> +#ifdef CONFIG_NUMA
> +	{
> +		.ctl_name	= VM_ZONE_RECLAIM_MODE,

> +		.strategy	= &zero,

zero is an 'int', while strategy is ctl_handler *.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
