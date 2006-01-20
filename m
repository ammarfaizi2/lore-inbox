Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030203AbWATFsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030203AbWATFsU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 00:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030264AbWATFsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 00:48:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22406 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030203AbWATFsT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 00:48:19 -0500
Date: Thu, 19 Jan 2006 21:47:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Brown, Len" <len.brown@intel.com>
Cc: pavel@ucw.cz, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm1 usb hub problems
Message-Id: <20060119214759.18d5c832.akpm@osdl.org>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3005C6CEE4@hdsmsx401.amr.corp.intel.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005C6CEE4@hdsmsx401.amr.corp.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Brown, Len" <len.brown@intel.com> wrote:
>
> This is new:
> 
>  >+PCI: Found IBM Dock II Cardbus Bridge applying quirk
>  >+PCI: Found IBM Dock II Cardbus Bridge applying quirk

Ah.  Thanks.  gregkh-pci-pci-quirk-for-ibm-dock-ii-cardbus-controllers.patch.

Pavel, if you disable quirk_ibm_dock2_cardbus(), does it fix?
