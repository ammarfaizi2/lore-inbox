Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262342AbVBQTRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262342AbVBQTRA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 14:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbVBQTPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 14:15:25 -0500
Received: from it4systems-kln-gw.de.clara.net ([212.6.222.118]:47589 "EHLO
	frankbuss.de") by vger.kernel.org with ESMTP id S262359AbVBQTOh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 14:14:37 -0500
From: "Frank Buss" <fb@frank-buss.de>
To: "'Russell King'" <rmk+lkml@arm.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Problems with dma_mmap_writecombine on mach-pxa
Date: Thu, 17 Feb 2005 20:14:34 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <20050217181241.A22752@flint.arm.linux.org.uk>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Thread-Index: AcUVHN67XMSPg0F1TSWXpf/AWJWRgwAB6hWw
Message-Id: <20050217191436.942345B874@frankbuss.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please try this (and revert your changes):

thanks, this could fix the bug with the vm_pgoff, but I don't think this
will fix the problem with the ignored memory access after the first
PAGE_SIZE from the mapped memory. I'll try it tommorow, when I'm again at my
customers site, where I have access to the board.

-- 
Frank Buﬂ, fb@frank-buss.de
http://www.frank-buss.de, http://www.it4-systems.de

