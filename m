Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbUCCW2T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 17:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbUCCW2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 17:28:19 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:40834 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S261191AbUCCW2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 17:28:15 -0500
Date: Wed, 3 Mar 2004 22:27:12 +0000
From: Dave Jones <davej@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Cpufreq mailing list <cpufreq@www.linux.org.uk>,
       kernel list <linux-kernel@vger.kernel.org>, davej@codemonkey.ork.uk
Subject: Re: powernow-k8-acpi driver
Message-ID: <20040303222712.GA16874@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Pavel Machek <pavel@ucw.cz>,
	Cpufreq mailing list <cpufreq@www.linux.org.uk>,
	kernel list <linux-kernel@vger.kernel.org>, davej@codemonkey.ork.uk
References: <20040303215435.GA467@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303215435.GA467@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 10:54:36PM +0100, Pavel Machek wrote:
 > Hi!
 > 
 > Lots of machines have broken PST tables, so current in-kernel driver
 > refuses to works on them. Vendors do get ACPI tables right because
 > apparently Windows use them ;-). So this driver tends to work.
 > 
 > Comments? Could we get this into mainline?

I really dislike the idea of having >1 driver for this.
Why can't we have a "use_acpi" module_param to switch to this ?

		Dave
