Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262756AbUKRP6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbUKRP6s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 10:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262527AbUKRPzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 10:55:33 -0500
Received: from fsmlabs.com ([168.103.115.128]:37594 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262756AbUKRPyc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 10:54:32 -0500
Date: Thu, 18 Nov 2004 08:54:10 -0700 (MST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andi Kleen <ak@suse.de>
cc: kernel-stuff@comcast.net, linux-kernel@vger.kernel.org
Subject: Re: X86_64: Many Lost ticks
In-Reply-To: <20041118050624.GB1478@wotan.suse.de>
Message-ID: <Pine.LNX.4.61.0411180852210.7181@musoma.fsmlabs.com>
References: <111820040402.18259.419C1EEE000EC75D00004753220075115000009A9B9CD3040A029D0A05@comcast.net>
 <20041118050624.GB1478@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2004, Andi Kleen wrote:

> On Thu, Nov 18, 2004 at 04:02:55AM +0000, kernel-stuff@comcast.net wrote:
> > I have a X86_64 laptop (Compaq Presario R3240) with all BIOS updates in place. I routinely get the "Warning : many lost ticks" message in dmesg. 
> 
> Known problem.  ACPI uses a broken way to access the EC register,
> and VIA chipsets take extremly long for this operation.  This
> happens regularly to read the system temperature.
> A fix is currently being discussed. 

It's an nforce3, do those also have a similar issue? I have similar 
hardware and rarely see it, could you test a newer kernel?
