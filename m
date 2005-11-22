Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030242AbVKVXfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbVKVXfU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 18:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030250AbVKVXfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 18:35:19 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:22924 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1030242AbVKVXfS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 18:35:18 -0500
Date: Tue, 22 Nov 2005 15:35:15 -0800
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jani Monoses <jani.monoses@gmail.com>
Subject: Re: BUG 2.6.14.2 : ACPI boot lockup
Message-ID: <20051122233515.GA29974@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes wrote :
>	The pristine 2.6.14.2 kernel lockup at boot on my
> laptop. Kernel 2.6.11 did boot properly, as far as I could see. Did
> not try versions in between.

	Adding the following options to the kernel command line
(lilo.conf;grub/menu.lst) did workaround the issue :
--------------------------------
pci=noacpi ec_burst=1
--------------------------------
	I believe the second one is not needed.

	Have fun...

	Jean

