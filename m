Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752461AbWCQAk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461AbWCQAk5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 19:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752462AbWCQAk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 19:40:57 -0500
Received: from palrel10.hp.com ([156.153.255.245]:28347 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S1752461AbWCQAk4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 19:40:56 -0500
Date: Thu, 16 Mar 2006 16:41:08 -0800
From: Grant Grundler <iod00d@hp.com>
To: Greg KH <gregkh@suse.de>
Cc: Grant Grundler <iod00d@hp.com>, Mark Maule <maule@sgi.com>,
       "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, shaohua.li@intel.com
Subject: Re: [PATCH] (-mm) drivers/pci/msi: explicit declaration of msi_register
Message-ID: <20060317004108.GH9746@esmail.cup.hp.com>
References: <44172F0E.6070708@ce.jp.nec.com> <20060314134535.72eb7243.akpm@osdl.org> <44176502.9050109@ce.jp.nec.com> <20060315235544.GA6504@suse.de> <44198210.6090109@ce.jp.nec.com> <20060316181934.GM13666@sgi.com> <20060316234118.GB9746@esmail.cup.hp.com> <20060316234906.GA24675@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060316234906.GA24675@suse.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 03:49:06PM -0800, Greg KH wrote:
> > There are other transaction based interrupt subsystems that are typically
> > arch specific (e.g. GSC device interrupts on PA-RISC). So far, MSI is the
> > only generic one and that is clearly part of the PCI spec. 
> 
> Yes, that's fine.  But the core pci msi structures do not need to be
> exported for the whole kernel to see, right?  That's my only point here.

Yes, got it. I agree.

grant
