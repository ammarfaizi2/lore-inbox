Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbVCNJai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbVCNJai (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 04:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262083AbVCNJah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 04:30:37 -0500
Received: from mail.math.TU-Berlin.DE ([130.149.12.212]:34809 "EHLO
	mail.math.TU-Berlin.DE") by vger.kernel.org with ESMTP
	id S261415AbVCNJaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 04:30:30 -0500
From: Thomas Richter <thor@math.TU-Berlin.DE>
Message-Id: <200503140930.KAA08568@mersenne.math.tu-berlin.de>
Subject: Re: Fw: [Bugme-new] [Bug 4334] New: kernel support for netmos 9835/9735
 crippled since 2.6.9
In-Reply-To: <20050313123754.78ab76a0.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 14 Mar 2005 10:30:22 +0100 (CET)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL108 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,
 
> I'm inclined to simply revert that change.

In case the mentioned lines do cause problems, please do not hesitate
to remove them. As the comments indicate, the patch was completely
untested as I haven't had the cards available. However, please ensure
that the parallel port remains available for the 9835/9735 in case
they are removed from the parport module. Their references should be
removed *only* from parport_pc, not from the PCI name database.

So long,
	Thomas

