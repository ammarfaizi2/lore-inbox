Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262817AbUKXTKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262817AbUKXTKT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 14:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262821AbUKXTID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 14:08:03 -0500
Received: from palrel12.hp.com ([156.153.255.237]:33709 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262775AbUKXTFz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 14:05:55 -0500
Date: Wed, 24 Nov 2004 10:54:51 -0800
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: How to perform a Wireless Scan?
Message-ID: <20041124185451.GA29598@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias-Christian Ott wrote :
> 
> I'm currently developing the the wireless functions for the rtl8180
> chipset.
> There's only one problem:
> I don't know how to perform a wireless scan.
> How does it work?
> Is there an algorithm or a GPL based driver which does this well?

	Most modern wireless drivers support the scan function (airo,
hostap, orinoco v15, prism54, atmel_cs, wl3501, madwifi, ipw2x00,
acx100, poldhu, at76c503, adm8211... - check my Howto).
	Unfortunately, the implementation is highly dependant on the
hardware itself, and each hardware has it's own way. Chipset which are
"softer" require more work. A good example of harder MAC is
airo/orinoco, for softer MAC check madwifi.
	Good luck...

	Jean

