Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262532AbUCLXrS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 18:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262746AbUCLXrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 18:47:18 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:27569 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S262532AbUCLXrQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 18:47:16 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>,
       long <tlnguyen@snoqualmie.dp.intel.com>
Subject: Re: RE[PATCH]2.6.4-rc3 MSI Support for IA64
Date: Fri, 12 Mar 2004 16:47:08 -0700
User-Agent: KMail/1.5.4
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       davidm@napali.hpl.hp.com, grep@kroah.com, jgarzik@pobox.com,
       jun.nakajima@intel.com, tom.l.nguyen@intel.com, tony.luck@intel.com
References: <200403130008.i2D08SMQ011709@snoqualmie.dp.intel.com> <Pine.LNX.4.58.0403121743310.29087@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.58.0403121743310.29087@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403121647.08404.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 March 2004 4:26 pm, Zwane Mwaikambo wrote:
> This one is slightly confusing readability wise since ia64 already does
> the vector based interrupt numbering. Perhaps CONFIG_PCI_USE_VECTOR should
> really be CONFIG_MSI but that's up to you.

I don't know much about MSI, but it certainly confused me that the
config symbol is CONFIG_PCI_USE_VECTOR.  I think CONFIG_PCI_MSI would
make the most sense, but maybe it's too late.

