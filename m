Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263046AbUKTCqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263046AbUKTCqD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 21:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263050AbUKTCp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 21:45:57 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:23171 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S263070AbUKTCnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:43:13 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: pci-resume patch from 2.6.7-rc2 breakes S3 resume on some machines
In-Reply-To: <1100905563.3812.59.camel@gaston>
References: <1100811950.3470.23.camel@mhcln03> <20041119115507.GB1030@elf.ucw.cz> <1100872578.3692.7.camel@mhcln03> <1100872578.3692.7.camel@mhcln03> <1100905563.3812.59.camel@gaston>
Date: Sat, 20 Nov 2004 02:43:12 +0000
Message-Id: <E1CVLDU-0005jG-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

>> Sorry, that's beyond my abilities. That's why I'm posting here. I'm not
>> even sure that it's the radeon which is acting up here.
> 
> Have you tried with radeonfb in your kernel config ?

In the general case, it's harder to resume systems using framebuffers
than systems that don't. The contortions that are necessary for non-fb
systems tend to break fb systems (you end up with userspace and the
kernel both trying to get the graphics hardware back into a sane state),
so in an ideal world resume would work without any framebuffer support.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
