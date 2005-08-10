Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965030AbVHJH2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965030AbVHJH2Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 03:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965031AbVHJH2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 03:28:24 -0400
Received: from ozlabs.org ([203.10.76.45]:50839 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965030AbVHJH2X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 03:28:23 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17145.44403.945337.623306@cargo.ozlabs.ibm.com>
Date: Wed, 10 Aug 2005 17:32:03 +1000
From: Paul Mackerras <paulus@samba.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linas@austin.ibm.com
Subject: Re: [RFC/PATCH] Add pci_walk_bus function to PCI core
In-Reply-To: <1123654250.3217.5.camel@laptopd505.fenrus.org>
References: <17145.23098.798473.364481@cargo.ozlabs.ibm.com>
	<1123654250.3217.5.camel@laptopd505.fenrus.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven writes:

> is there a way to avoid the recursion somehow? Recursion is "not fun"
> stack usage wise, esp if you have really deep hierarchies....

Yes, since we have pointers up the tree as well as down, it should in
fact be easy.  I'll hack something up.

Paul.
