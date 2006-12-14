Return-Path: <linux-kernel-owner+w=401wt.eu-S932699AbWLNMfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932699AbWLNMfN (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 07:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932698AbWLNMfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 07:35:13 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39412 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932700AbWLNMfL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 07:35:11 -0500
Date: Thu, 14 Dec 2006 12:42:41 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: =?UTF-8?B?SGFucy1Kw7xyZ2Vu?= Koch <hjk@linutronix.de>
Cc: "Hua Zhong" <hzhong@gmail.com>, "'Martin J. Bligh'" <mbligh@mbligh.org>,
       "'Linus Torvalds'" <torvalds@osdl.org>, "'Greg KH'" <gregkh@suse.de>,
       "'Jonathan Corbet'" <corbet@lwn.net>, "'Andrew Morton'" <akpm@osdl.org>,
       "'Michael K. Edwards'" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
 for 2.6.19]
Message-ID: <20061214124241.44347df6@localhost.localdomain>
In-Reply-To: <200612141231.17331.hjk@linutronix.de>
References: <4580E37F.8000305@mbligh.org>
	<003801c71f45$45d722c0$6721100a@nuitysystems.com>
	<20061214111439.11bed930@localhost.localdomain>
	<200612141231.17331.hjk@linutronix.de>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2006 12:31:16 +0100
Hans-Jürgen Koch <hjk@linutronix.de> wrote:
> You think it's easier for a manufacturer of industrial IO cards to
> debug a (large) kernel module?

You think its any easier to debug because the code now runs in ring 3 but
accessing I/O space.


> > uio also doesn't handle hotplug, pci and other "small" matters.
> 
> uio is supposed to be a very thin layer. Hotplug and PCI are already
> handled by other subsystems. 

And if you have a PCI or a hotplug card ? How many industrial I/O cards
are still ISA btw ?


Alan
