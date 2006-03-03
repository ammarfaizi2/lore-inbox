Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161018AbWCCSbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161018AbWCCSbP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 13:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161021AbWCCSbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 13:31:15 -0500
Received: from fmr22.intel.com ([143.183.121.14]:22206 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1161018AbWCCSbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 13:31:14 -0500
Date: Fri, 3 Mar 2006 10:30:02 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: jensmh@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc5 'lost' cpu
Message-ID: <20060303103002.A26876@unix-os.sc.intel.com>
References: <Pine.LNX.4.64.0603030954230.28074@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.64.0603030954230.28074@montezuma.fsmlabs.com>; from zwane@arm.linux.org.uk on Fri, Mar 03, 2006 at 09:54:34AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2006 at 09:54:34AM -0800, Zwane Mwaikambo wrote:
> 
>    > > Can you try sending dmesg output too?
>    >
>    >  here it is, but this time all 4 cpus are detected. Later I will try
>    some reboots
>    > and check if I can reproduce the problem.
> 
>    Thanks, i'll wait for those results.

Next time it happens, please send dmesg, and also 

cat /proc/acpi/processor/*

ls /sys/devices/system/cpu

would be useful.. Dont know if bios disabled one thread for some reason
