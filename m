Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263893AbUECTWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbUECTWb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 15:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263895AbUECTWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 15:22:31 -0400
Received: from fmr99.intel.com ([192.55.52.32]:51092 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S263893AbUECTW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 15:22:29 -0400
Subject: Re: 2.6.6-rc3-mm1: modular ACPI button broken
From: Len Brown <len.brown@intel.com>
To: Valdis.Kletnieks@vt.edu
Cc: Adrian Bunk <bunk@fs.tum.de>, Harald Arnesen <harald@skogtun.org>,
       Luming Yu <luming.yu@intel.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <200405031836.i43IaoXc002664@turing-police.cc.vt.edu>
References: <20040430014658.112a6181.akpm@osdl.org>
	 <87ad0sshku.fsf@basilikum.skogtun.org> <20040501114420.GF2541@fs.tum.de>
	 <200405031836.i43IaoXc002664@turing-police.cc.vt.edu>
Content-Type: text/plain
Organization: 
Message-Id: <1083612060.591.9.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 03 May 2004 15:21:00 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-03 at 14:36, Valdis.Kletnieks@vt.edu wrote:
> On Sat, 01 May 2004 13:44:21 +0200, Adrian Bunk said:
> 
> > This seems to be introduced by the button driver unload unload patch 
> > (Bugzilla #2281) included in the ACPI BK patch.
> > 
> > It seems two EXPORT_SYMBOL's are missing in scan.c?
> 
> And a needed #include, as well (found that out the hard way).  Here's
> the "works for me" patch...

I should have mentioned that I pushed the works-for-me patch to linus a
few hours ago -- so -mm will get it that way.

Note also with the existing -mm tree you can always
CONFIG_ACPI_BUTTON=y instead of using a module for now.

thanks,
-Len


