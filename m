Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268322AbTGIOFv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 10:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268325AbTGIOFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 10:05:51 -0400
Received: from franka.aracnet.com ([216.99.193.44]:16108 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S268322AbTGIOFu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 10:05:50 -0400
Date: Wed, 09 Jul 2003 07:20:11 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: gigag@bezeqint.net, linux-kernel@vger.kernel.org
Subject: Re: Known problems for 3.5/0.5 virtual space split???
Message-ID: <69110000.1057760411@[10.10.2.4]>
In-Reply-To: <a4ba947b.a0a80e9b.81ab200@mas3.bezeqint.net>
References: <a4ba947b.a0a80e9b.81ab200@mas3.bezeqint.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wonder if there are any known problems for applying 
> 2.4.21rc8aa1 patch from Andrea?
> 
> I'm trying to boot a Xeon 2.4 box with 4GB of RAM, IDE CD and 
> Adaptec AIC7XXX SCSI devices.
> 
> I compile the kernel with 1/3 split and it boots OK. When I simply 
> change the split to 3.5/0.5, it gets stuck during the boot not being 
> able to mount root partition.
> 
> Any ideas? Any other working kernel/patch configurations for h/w 
> like I have?

Odd - should work. Post a boot log (use a serial console).

Also, if you can try 2.5-mjb tree, that should have a forward port of
the same concept ... does it work there?

M.

