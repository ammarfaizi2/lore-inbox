Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262534AbTCMUN4>; Thu, 13 Mar 2003 15:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262535AbTCMUN4>; Thu, 13 Mar 2003 15:13:56 -0500
Received: from mail4.bluewin.ch ([195.186.4.74]:56522 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id <S262534AbTCMUNz>;
	Thu, 13 Mar 2003 15:13:55 -0500
Date: Thu, 13 Mar 2003 21:24:07 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Daniel Egger <degger@fhm.edu>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20 and 2.5.64 NIC missing interrupts in APIC mode
Message-ID: <20030313202407.GA10774@k3.hellgate.ch>
Mail-Followup-To: Daniel Egger <degger@fhm.edu>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <1047581900.1513.36.camel@sonja>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047581900.1513.36.camel@sonja>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.64 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Mar 2003 19:58:21 +0100, Daniel Egger wrote:
> As soon as I enable the APIC mode in the BIOS the onboard PHY seems
> to ignore any packets which are thrown at it *after* the kernel
> initialised itself which is especially nasty since the system is booting
> from network effectively stopping its boot when trying to get an IP
> using DHCP or mounting a NFS volume in case the IP is fixed. The onboard
> NIC is a VIA Rhine II (VT6102).

You may want to try 2.4.x-ac kernels, I believe Alan fixed some VIA APIC
issues.

Roger
