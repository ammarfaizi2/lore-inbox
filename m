Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267249AbUGVUiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267249AbUGVUiw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 16:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267251AbUGVUiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 16:38:52 -0400
Received: from ozlabs.org ([203.10.76.45]:30090 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267249AbUGVUh5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 16:37:57 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16640.9278.416147.515293@cargo.ozlabs.ibm.com>
Date: Thu, 22 Jul 2004 16:31:58 -0400
From: Paul Mackerras <paulus@samba.org>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org,
       linas@linas.org
Subject: Re: Remail: [PATCH] 2.6 PPC64: PCI Config Space reads need EEH checking
In-Reply-To: <20040721212621.GZ13171@austin.ibm.com>
References: <20040721212621.GZ13171@austin.ibm.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas Vepstas writes:

> This patch adds explicit checking for EEH slot isolation events into the 
> PCI config space read path.  The change itself would have been minor,
> except that pci config reads don't have a pointer to a struct pci_dev.
> Thus, I had to restructure the eeh code to accomodate this, which
> seems to be a good thing anyway, making it a tad cleaner.   This patch
> presumes the earlier patches i.e. the notifier-call chain patch) have
> been applied.
> 
> Please forward upstream if all's OK.
> 
> Signed-off-by: Linas Vepstas <linas@linas.org>
> 
> --linas 
> 
> ----- End forwarded message -----

-ENOPATCH :)

Paul.
