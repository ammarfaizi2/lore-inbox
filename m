Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752370AbWCPXlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370AbWCPXlJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 18:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752225AbWCPXlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 18:41:09 -0500
Received: from palrel10.hp.com ([156.153.255.245]:20385 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S1751433AbWCPXlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 18:41:08 -0500
Date: Thu, 16 Mar 2006 15:41:18 -0800
From: Grant Grundler <iod00d@hp.com>
To: Mark Maule <maule@sgi.com>
Cc: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>, Greg KH <gregkh@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, shaohua.li@intel.com
Subject: Re: [PATCH] (-mm) drivers/pci/msi: explicit declaration of msi_register
Message-ID: <20060316234118.GB9746@esmail.cup.hp.com>
References: <44172F0E.6070708@ce.jp.nec.com> <20060314134535.72eb7243.akpm@osdl.org> <44176502.9050109@ce.jp.nec.com> <20060315235544.GA6504@suse.de> <44198210.6090109@ce.jp.nec.com> <20060316181934.GM13666@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060316181934.GM13666@sgi.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 12:19:34PM -0600, Mark Maule wrote:
> If there's objectins to having struct msi_ops declared in pci.h, then I guess
> we need to come up with another solution.

There are other transaction based interrupt subsystems that are typically
arch specific (e.g. GSC device interrupts on PA-RISC). So far, MSI is the
only generic one and that is clearly part of the PCI spec. 

grant
