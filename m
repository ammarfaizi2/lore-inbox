Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265252AbUAFCJK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 21:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265255AbUAFCJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 21:09:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:5092 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265252AbUAFCJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 21:09:07 -0500
Date: Mon, 5 Jan 2004 18:08:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Cc: linux-kernel@vger.kernel.org, linux-acpi@intel.com
Subject: Re: ACPI battery problem with 2.6.1-rc1-mm2 kernel patch
Message-Id: <20040105180859.7e20e87a.akpm@osdl.org>
In-Reply-To: <1073354003.4101.11.camel@idefix.homelinux.org>
References: <1073354003.4101.11.camel@idefix.homelinux.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca> wrote:
>
> Hi,
> 
> I've just tried 2.6.1-rc1-mm2 and noticed that I can no longer get the
> battery status through ACPI (/proc/acpi/battery/BAT0/state reports only
> zeros). While my dsdt may be a bit buggy, it worked fine with 2.6.1-rc1,
> so there seems to be a regression somewhere. I haven't tried earlier -mm
> patches though.
> 
> I'm running Fedora Core 1 on Dell Latitute D600 (Pentium M 1.6, 1 GB
> RAM). I can do more testing if that's useful.
> 

Thanks, the acpi-20031203 patch seems to have introduced a handful of
regressions.


