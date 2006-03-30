Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWC3IZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWC3IZM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 03:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbWC3IZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 03:25:12 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:7091 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932108AbWC3IZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 03:25:10 -0500
Date: Thu, 30 Mar 2006 10:24:30 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Nigel Cunningham <ncunningham@cyclades.com>
cc: Ashok Raj <ashok.raj@intel.com>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, rjw@sisk.pl
Subject: Re: [rfc] fix Kconfig, hotplug_cpu is needed for swsusp
In-Reply-To: <200603300953.32298.ncunningham@cyclades.com>
Message-ID: <Pine.LNX.4.61.0603301022400.30783@yvahk01.tjqt.qr>
References: <20060329220808.GA1716@elf.ucw.cz> <200603300936.22757.ncunningham@cyclades.com>
 <20060329154748.A12897@unix-os.sc.intel.com> <200603300953.32298.ncunningham@cyclades.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Most people don't seem to know 
>about '/' in make menuconfig.

I find it very confusing to use, since it returns too verbose text to skim 
through. Probably the search function should be split into "only search 
titles[*]" and "search description too".


  config UNIX
    bool "Unix socket"            <-- that's a "title", as in menuconfig



Jan Engelhardt
-- 
