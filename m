Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265768AbUF2Ocs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265768AbUF2Ocs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 10:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265766AbUF2Ocs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 10:32:48 -0400
Received: from iris-63.mc.com ([63.96.239.5]:43463 "EHLO mc.com")
	by vger.kernel.org with ESMTP id S265768AbUF2Ocq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 10:32:46 -0400
Subject: Re: DRAM and PCI devices at same physical address
From: Matt Sexton <sexton@mc.com>
To: Ross Biro <ross.biro@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <8783be6604062812277ee07aa@mail.gmail.com>
References: <1088198580.29697.62.camel@dhcp_client-120-140>
	 <8783be6604062812277ee07aa@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1088519490.16108.8.camel@dhcp_client-120-140>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 29 Jun 2004 10:31:30 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-06-28 at 15:27, Ross Biro wrote:
> On 25 Jun 2004 17:23:00 -0400, Matt Sexton <sexton@mc.com> wrote:
> 
> > 
> > Should they be appearing there at all?  Does Linux make any guarantees
> > when there is more physical memory than specified by "mem=" ?
> 
> You've told linux there is only 512M of physical memory and it
> believes you, so it is using the available address space for memory
> mapped i/o.  I know of no way to reserve memory on the command line.

Fair enough.  I was just following the advice of the "Linux Device
Drivers" book by Rubini & Corbet, where in the "Reserving High RAM
Addresses" section of Chapter 7, they describe exactly this method of
reserving memory for device drivers.

Matt

