Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263275AbUKZXLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263275AbUKZXLs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 18:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263274AbUKZTsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:48:43 -0500
Received: from zeus.kernel.org ([204.152.189.113]:4291 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262507AbUKZT25 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:28:57 -0500
Subject: Re: [PATCH 1/2] pci: Block config access during BIST
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, brking@us.ibm.com,
       Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <16806.21992.295157.530799@cargo.ozlabs.ibm.com>
References: <200411192023.iAJKNNSt004374@d03av02.boulder.ibm.com>
	 <1100917635.9398.12.camel@localhost.localdomain>
	 <1100934567.3669.12.camel@gaston>
	 <1100954543.11822.8.camel@localhost.localdomain>
	 <16806.21992.295157.530799@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101417118.18177.66.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 25 Nov 2004 21:11:59 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-11-25 at 22:00, Paul Mackerras wrote:
> read the patch?  All that we are doing is testing one bit in the
> struct pci_dev to see whether to do the actual access or not.  Or do
> you want one bit to tell us whether to go and look at another bit to
> see whether to do the access? :)

Rereading the newer patch and following the pci_lock move properly this
time it looks fine now.

