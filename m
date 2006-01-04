Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750910AbWADWyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbWADWyY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbWADWyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:54:24 -0500
Received: from [81.2.110.250] ([81.2.110.250]:53187 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750852AbWADWyX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:54:23 -0500
Subject: Re: [PATCH 2.6.15 1/2] ia64: use i386 dmi_scan.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: linux-ia64@vger.kernel.org, ak@suse.de,
       openipmi-developer@lists.sourceforge.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060104221627.GA26064@lists.us.dell.com>
References: <20060104221627.GA26064@lists.us.dell.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 04 Jan 2006 22:55:55 +0000
Message-Id: <1136415355.7443.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-01-04 at 16:16 -0600, Matt Domsch wrote:
> Andi Kleen has a patch in his x86_64 tree which enables the use of
> i386 dmi_scan.c on x86_64.  dmi_scan.c functions are being used by the
> drivers/char/ipmi/ipmi_si_intf.c driver for autodetecting the ports or
> memory spaces where the IPMI controllers may be found.
> 
> This patch adds equivalent changes for ia64 as to what is in the
> x86_64 tree.

I was under the impression that the correct way to find the DMI tables
on IA64 was by the EFI[ng ;)] firmware interface

