Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbVIHOaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbVIHOaB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 10:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbVIHOaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 10:30:00 -0400
Received: from dvhart.com ([64.146.134.43]:32394 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1751364AbVIHOaA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 10:30:00 -0400
Date: Thu, 08 Sep 2005 07:30:01 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: Andi Kleen <ak@suse.de>
Subject: Re: 2.6.13-mm2
Message-ID: <73450000.1126189801@[10.10.2.4]>
In-Reply-To: <20050908053042.6e05882f.akpm@osdl.org>
References: <20050908053042.6e05882f.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13-mm2/
> 
> (kernel.org propagation is slow.  There's a temp copy at
> http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.13-mm2.bz2)
> 
> 
> 
> - Added Andi's x86_64 tree, as separate patches
> 
> - Added a driver for TI acx1xx cardbus wireless NICs
> 
> - Large revamp of pcmcia suspend handling
> 
> - Largeish v4l and DVB updates
> 
> - Significant parport rework
> 
> - Many tty drivers still won't compile
> 
> - Lots of framebuffer driver updates
> 
> - There are still many patches here for 2.6.14.  We're doing pretty well
>   with merging up the subsystem trees.  ia64 and CIFS are still pending. 
>   x86_64 and several of Greg's trees (especially USB) aren't merged yet.

Build fails on x86_64, at least, with this config:
http://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/abat/amd64

arch/x86_64/pci/built-in.o(.init.text+0xa88): In function `pci_acpi_scan_root':
: undefined reference to `pxm_to_node'
make: *** [.tmp_vmlinux1] Error 1
09/08/05-06:52:31 Build the kernel. Failed rc = 2
09/08/05-06:52:31 build: kernel build Failed rc = 1
09/08/05-06:52:31 command complete: (2) rc=126
Failed and terminated the run

