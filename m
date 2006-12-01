Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936499AbWLAN3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936499AbWLAN3f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 08:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936498AbWLAN3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 08:29:35 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20743 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S936499AbWLAN3f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 08:29:35 -0500
Date: Fri, 1 Dec 2006 13:29:18 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Ben Collins <bcollins@ubuntu.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH 1/4] [x86] Add command line option to enable/disable hyper-threading.
Message-ID: <20061201132918.GB4239@ucw.cz>
References: <11648607683157-git-send-email-bcollins@ubuntu.com> <11648607733630-git-send-email-bcollins@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11648607733630-git-send-email-bcollins@ubuntu.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch adds a config option to allow disabling hyper-threading by
> default, and a kernel command line option to changes this default at
> boot time.

> +config X86_HT_DISABLE
> +	bool "Disable Hyper-Threading by default"
> +	depends on X86_HT
> +	default n
> +

Command line options are fine, but additional config options mirroring
command line functionality look ugly to me...

							Pavel
-- 
Thanks for all the (sleeping) penguins.
