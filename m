Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266189AbUJATQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266189AbUJATQk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 15:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266193AbUJATQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 15:16:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:21449 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266170AbUJATQj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 15:16:39 -0400
Date: Fri, 1 Oct 2004 12:14:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Sy, Dely L" <dely.l.sy@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm4 - Getting dev->irq equals 0
Message-Id: <20041001121421.6f47861a.akpm@osdl.org>
In-Reply-To: <468F3FDA28AA87429AD807992E22D07E02B9512F@orsmsx408>
References: <468F3FDA28AA87429AD807992E22D07E02B9512F@orsmsx408>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Sy, Dely L" <dely.l.sy@intel.com> wrote:
>
> Andrew,
> 
> I encountered a problem in running shpchp & pciehp drivers on
> 2.6.9-rc2-mm4 kernel.  With ACPI & MSI enabled in the kernel, I 
> got dev->irq properly for the hot-plug controllers.  With ACPI 
> enabled and MSI not-enabled in this kernel, I got dev->irq 
> equal 0 for the controllers. With the same options set in 
> 2.6.8.1 & 2.6.9-rc2, things worked fine on the same system.
> 
> Do you know of any changes in the -mm4 that might have caused this
> problem?

Sorry, no, I cannot suggest where the problem lies.  Possibly
bk-acpi.patch, but that's quite small at present.
