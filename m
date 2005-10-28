Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030439AbVJ1W4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030439AbVJ1W4S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 18:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030441AbVJ1W4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 18:56:18 -0400
Received: from gate.crashing.org ([63.228.1.57]:58586 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1030439AbVJ1W4R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 18:56:17 -0400
Subject: Re: PPC32 - No IDE/ATA devices on new PowerBook
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <15DF6933-2475-439D-BE0A-DC232B92FDB7@comcast.net>
References: <15DF6933-2475-439D-BE0A-DC232B92FDB7@comcast.net>
Content-Type: text/plain
Date: Sat, 29 Oct 2005 08:56:04 +1000
Message-Id: <1130540164.29054.130.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-28 at 17:55 -0400, Parag Warudkar wrote:
> I can't seem to get the kernel to detect the IDE CDROM and Hard-disk  
> at all on the latest (5,8) PowerBook revision - no IDE controller is  
> reported in the dmesg. I have tried 2.6.8 from debian as well as  
> 2.6.12x from Ubuntu and Gentoo.
> 
> Both  the HDD and CDROM drives look fairly routine stuff to me  
> although I am not sure what kind of IDE controller is inside..
> 
> Is there any point in trying newer kernels?

Not yet, I haven't had the machine I ordered yet so I haven't yet had a
chance to investigate/fix the problem. I suppose it's mostly a matter of
adding a new PCI ID to drivers/ide/ppc/pmac.c though.

Ben.


