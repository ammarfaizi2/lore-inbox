Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265225AbUAPBrQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 20:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbUAPBrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 20:47:16 -0500
Received: from modemcable178.89-70-69.mc.videotron.ca ([69.70.89.178]:42624
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S265225AbUAPBrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 20:47:15 -0500
Date: Thu, 15 Jan 2004 20:46:33 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Gaspar Bakos <gbakos@cfa.harvard.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: SMP kernel, only single processor appears (fwd)
In-Reply-To: <Pine.SOL.4.58.0401151807310.9382@antu.cfa.harvard.edu>
Message-ID: <Pine.LNX.4.58.0401152040060.4208@montezuma.fsmlabs.com>
References: <Pine.SOL.4.58.0401151807310.9382@antu.cfa.harvard.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jan 2004, Gaspar Bakos wrote:

> Hi,
>
> I have an Intel 7505VB2 dual Xeon motherboard with 2x2.66GHz CPUs, Redhat
> 9.0 and self-compiled 2.4.23 kernel. Interestingly, I see only one CPU
> with e.g. "top", or cat /proc/cpuinfo, etc.
>
> I have to tell though that I installed this system by cloning the disk of
> another PC, which is running a single processor; then booting in the dual
> processor computer from the cloned disk (with a bootfloppy), and then
> recompiling the kernel (and rebooting to the new SMP enabled kernel).
> Seems to me that this is not enough, and I might have missed something.
>
> Any advice would be welcome.

This looks like you have 2 physical processors. Perhaps you don't have
hyperthreading enabled, i presume you want 4 logical processors. Try the
"acpi=ht" kernel parameter.
