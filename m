Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVEFFUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVEFFUf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 01:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261152AbVEFFUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 01:20:35 -0400
Received: from ozlabs.org ([203.10.76.45]:43482 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261151AbVEFFUb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 01:20:31 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17018.64606.662481.104228@cargo.ozlabs.ibm.com>
Date: Fri, 6 May 2005 15:10:54 +1000
From: Paul Mackerras <paulus@samba.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] ppc64: rename arch/ppc64/kernel/pSeries_pci.c
In-Reply-To: <200504200152.58965.arnd@arndb.de>
References: <200504200149.22063.arnd@arndb.de>
	<200504200152.58965.arnd@arndb.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann writes:

> Rename pSeries_pci.c to rtas_pci.c as a preparation to generalize it
> for use by BPA. Most of the file can be used by any machine that
> implements rtas.

Hmmm, you rename pSeries_pci.c to rtas_pci.c and then in the next
patch you recreate pSeries_pci.c and move some stuff from rtas_pci.c
into it.  Could we have one patch that creates rtas_pci.c and just
moves stuff from pSeries_pci.c to it?

Paul.
