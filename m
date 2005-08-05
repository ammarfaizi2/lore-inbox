Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263087AbVHERXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263087AbVHERXF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 13:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263080AbVHERMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 13:12:48 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:2732 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S263081AbVHERMK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 13:12:10 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] 6700/6702PXH quirk
Date: Fri, 5 Aug 2005 11:12:04 -0600
User-Agent: KMail/1.8.1
Cc: Kristen Accardi <kristen.c.accardi@intel.com>,
       linux-kernel@vger.kernel.org, greg@kroah.com, rajesh.shah@intel.com
References: <1123259263.8917.9.camel@whizzy>
In-Reply-To: <1123259263.8917.9.camel@whizzy>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508051112.04652.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 August 2005 10:27 am, Kristen Accardi wrote:
> On the 6700/6702 PXH part, a MSI may get corrupted if an ACPI hotplug
> driver and SHPC driver in MSI mode are used together.  This patch will
> prevent MSI from being enabled for the SHPC.  

Can you outline the scenario that causes the corruption?  This patch
feels like a band-aid over a deeper problem.
