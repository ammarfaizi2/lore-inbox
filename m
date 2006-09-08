Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751011AbWIHRsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbWIHRsN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 13:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbWIHRsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 13:48:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52881 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751003AbWIHRsG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 13:48:06 -0400
Date: Fri, 8 Sep 2006 10:47:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: "Miles Lane" <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>
Subject: Re: 2.6.18-rc4-mm3 -- ACPI Error (utglobal-0125): Unknown exception
 code: 0xFFFFFFEA [20060707]
Message-Id: <20060908104745.bff2449a.akpm@osdl.org>
In-Reply-To: <200609081010.58186.bjorn.helgaas@hp.com>
References: <a44ae5cd0608262356j29c0234cl198fb207bcad383d@mail.gmail.com>
	<a44ae5cd0608270927w62216a00i70966f1e8a190878@mail.gmail.com>
	<a44ae5cd0609072025i136f9a04ib01ba9c01f332b29@mail.gmail.com>
	<200609081010.58186.bjorn.helgaas@hp.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Sep 2006 10:10:57 -0600
Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> On Thursday 07 September 2006 21:25, Miles Lane wrote:
> > Ping...
> > 
> > I just reproduced this ACPI error with 2.6.18-rc5-mm1 + all hotfixes +
> > a crypto patch from Herbert + two nodemgr patched from Stefan + a max
> > trace depth patch from Ingo.
> > 
> > Any additional debug information needed?  Any progress?
> 
> We identified the patch that causes the ACPI unknown exception,
> and I think Andrew will be removing it from the next -mm release.
> 
> If you want to try reverting it yourself, here's the patch:
> 
> http://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm3/broken-out/hot-add-mem-x86_64-acpi-motherboard-fix.patch

Yes, that was omitted from rc6-mm1.
