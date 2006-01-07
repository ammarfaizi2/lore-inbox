Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161042AbWAGW6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161042AbWAGW6T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 17:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161043AbWAGW6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 17:58:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7116 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161042AbWAGW6S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 17:58:18 -0500
Date: Sat, 7 Jan 2006 14:58:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: linux-kernel@vger.kernel.org, "Brown, Len" <len.brown@intel.com>,
       linux-acpi@vger.kernel.org
Subject: Re: 2.6.15-mm2
Message-Id: <20060107145800.113d7de5.akpm@osdl.org>
In-Reply-To: <43C0172E.7040607@ens-lyon.org>
References: <20060107052221.61d0b600.akpm@osdl.org>
	<43C0172E.7040607@ens-lyon.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice Goglin <Brice.Goglin@ens-lyon.org> wrote:
>
> 2) acpi-cpufreq does not load either, returns ENODEV too. It's probably
>  git-acpi. I tried to revert it but there are lots of other patches
>  depending on it, so I finally gave up.

OK, let me try to reproduce this.  acpi and cpufreq are fully merged up, so
this bug may well be in mainline now.

>  3) wpa_supplicant does not find my WPA network anymore (while iwlist
>  scanning sees). I didn't see anything relevant in dmesg. My driver is
>  ipw2200.

It's things like this which make me consider a career in carpentry.

I assume 2.6.15 works OK?

Unfortunately I don't know diddly about wpa_supplicant (how come FC5-test1
doesn't ship it?)

