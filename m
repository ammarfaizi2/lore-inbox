Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261833AbVA3XWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbVA3XWz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 18:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbVA3XWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 18:22:55 -0500
Received: from gate.crashing.org ([63.228.1.57]:62617 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261833AbVA3XWo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 18:22:44 -0500
Subject: Re: [gentoo-ppc-dev] CONFIG_THERM_PM72 is missing from .config
	from recent kernels (2.6.10, 2.6.11)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Maurice Volaski <mvolaski@aecom.yu.edu>
Cc: Michael Hanselmann <hansmi@gentoo.org>, gentoo-ppc-dev@lists.gentoo.org,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <a0620073cbe21c8047634@[129.98.90.227]>
References: <a06200736be209a45bd65@[129.98.90.227]>
	 <20050129103057.GA27803@hansmi.ch>  <a0620073cbe21c8047634@[129.98.90.227]>
Content-Type: text/plain
Date: Mon, 31 Jan 2005 10:21:13 +1100
Message-Id: <1107127273.5713.13.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-01-29 at 18:41 -0500, Maurice Volaski wrote:

>  From what I can tell, the .config file is built up from different 
> files. I just looked at gentoo-dev-sources for this version and it 
> is, in fact, present for ppc64 in
> /usr/src/linux-2.6.10-gentoo-r6/arch/ppc64/defconfig
> 
> That suggests the mechanism that generates the .config files is not 
> working right under certain circumstances related to the 64bit G5.

The default config for G5s is arch/ppc64/configs/g5_defconfig, there is
only one for 64 bits. 32 bits on G5s is unsupported (and will probably
not work with more recent machines).

Ben.


