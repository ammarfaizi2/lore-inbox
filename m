Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267957AbUIFNJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267957AbUIFNJO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 09:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268010AbUIFNHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 09:07:49 -0400
Received: from the-village.bc.nu ([81.2.110.252]:34209 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268040AbUIFNGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 09:06:17 -0400
Subject: Re: [RFC] New Time of day proposal (updated 9/2/04)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Cc: Dominik Brodowski <linux@dominikbrodowski.de>,
       lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       george anzinger <george@mvista.com>, albert@users.sourceforge.net,
       clameter@sgi.com, Len Brown <len.brown@intel.com>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com, jimix@us.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, greg kh <greg@kroah.com>,
       Patricia Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>
In-Reply-To: <413C1F21.32130.254827@rkdvmks1.ngate.uni-regensburg.de>
References: <1094240482.14662.525.camel@cog.beaverton.ibm.com>
	 <413C1F21.32130.254827@rkdvmks1.ngate.uni-regensburg.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094470304.3817.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 06 Sep 2004 12:56:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-09-06 at 07:26, Ulrich Windl wrote:
> I would not mention SMP at that stage, but most of the existing code on IA32 
> suumes that all CPUs run with the same frequency. I only heared that at least on 

Except for the tsc functionality Linux 2.4.x/2.6.x does perfectly well
on split clock x86. Several people ran mixed 300/450Mhz systems with
dual celerons

