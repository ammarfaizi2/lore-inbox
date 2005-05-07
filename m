Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbVEGPBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbVEGPBr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 11:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVEGPBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 11:01:46 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:16654 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261430AbVEGPBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 11:01:09 -0400
Date: Sat, 7 May 2005 17:01:05 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jan Dittmer <jdittmer@ppp0.net>, Dave Hansen <haveblue@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] fix typo in arch/h8300/Kconfig.cpu
Message-ID: <20050507150104.GN3590@stusta.de>
References: <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002733.GH10124@redhat.com> <20050302203812.092f80a0.akpm@osdl.org> <20050304105247.B3932@flint.arm.linux.org.uk> <20050304032632.0a729d11.akpm@osdl.org> <20050304113626.E3932@flint.arm.linux.org.uk> <20050506235842.A23651@flint.arm.linux.org.uk> <427C9DBD.1030905@ppp0.net> <20050507122622.C11839@flint.arm.linux.org.uk> <427CC082.4000603@ppp0.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <427CC082.4000603@ppp0.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2005 at 03:20:02PM +0200, Jan Dittmer wrote:
> 
> Well I built something like this now which I mail to myself,
> overlook and then going sent to lkml:
>...
> - h8300: still broken
>   Details: http://l4x.org/k/?d=3480
>...
> Link to this page: http://l4x.org/k/?diff[v1]=mm

Trivial fix below.

> Jan

cu
Adrian


<--  snip  -->


This patch fixes a trivial typo in introduced by 
make-each-arch-use-mm-kconfig.patch .

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc3-mm3-full/arch/h8300/Kconfig.cpu.old	2005-05-07 16:59:48.000000000 +0200
+++ linux-2.6.12-rc3-mm3-full/arch/h8300/Kconfig.cpu	2005-05-07 17:00:12.000000000 +0200
@@ -181,6 +181,6 @@
 	bool "Preemptible Kernel"
 	default n
 
-source "mm/Kconfig'
+source "mm/Kconfig"
 
 endmenu

