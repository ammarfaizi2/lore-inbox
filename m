Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbUJWWLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbUJWWLd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 18:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbUJWWLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 18:11:33 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:14683 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261319AbUJWWLb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 18:11:31 -0400
From: Allan Sandfeld Jensen <allan@carewolf.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.9-mm1: NForce3 problem (IRQ sharing issue?)
Date: Sun, 24 Oct 2004 00:14:47 +0200
User-Agent: KMail/1.7.50
References: <200410222354.44563.rjw@sisk.pl>
In-Reply-To: <200410222354.44563.rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410240014.47507.allan@carewolf.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 October 2004 23:54, you wrote:
> Hi,
>
> I have a problem with 2.6.9-mm1 on an AMD64 NForce3-based box.  Namely,
> after some time in X, USB suddenly stops working and sound goes off
> simultaneously (it's quite annoying, as I use a USB mouse ;-)).  It is 100%
> reproducible and it may be related to the sharing of IRQ 5:
>
Have you tried disabling ioapic? 
I also lost a lot of input-related interrupts  when I started using 2.6 
kernels on my NForce3 laptop. Disabling ioapic was the only thing that has 
made it usable.
Seems like Nvidia even in their third try can't wire a correct APIC.

`Allan
