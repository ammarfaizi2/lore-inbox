Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbTKRIOp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 03:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbTKRIOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 03:14:45 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:11012 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S262108AbTKRIOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 03:14:44 -0500
Subject: Re: [USB] uhci-hcd.c: b400: host controller halted after ACPI S3
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Karol Kozimor <sziwan@hell.org.pl>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20031117232515.GA25925@hell.org.pl>
References: <20031117210528.GC20681@hell.org.pl>
	 <1069110451.7394.1.camel@teapot.felipe-alfaro.com>
	 <20031117232515.GA25925@hell.org.pl>
Content-Type: text/plain
Message-Id: <1069143280.2667.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Tue, 18 Nov 2003 09:14:41 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-11-18 at 00:25, Karol Kozimor wrote:
> > Try unloading uhci-hcd before suspending to S3. Then, load it again
> > after the system has been woken up from S3. At least, it works for me
> 
> Oh, yeah, I know it does, I'm just trying to get the problem fixed
> properly.

Oh! Good! I'm also trying to get this fixed, but I haven't seen any
progress on this issue (if my memory serves me well, Greg hadn't access
to a system with UHCI-HCD host controller to test).

