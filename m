Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268166AbUHQIMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268166AbUHQIMF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 04:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268157AbUHQIKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 04:10:50 -0400
Received: from gate.crashing.org ([63.228.1.57]:7073 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268146AbUHQIKQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 04:10:16 -0400
Subject: Re: page fault fastpath: Increasing SMP scalability by introducing
	pte locks?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-ia64@vger.kernel.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>
In-Reply-To: <Pine.LNX.4.58.0408161025420.9812@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com>
	 <1092609485.9538.27.camel@gaston>
	 <Pine.LNX.4.58.0408161025420.9812@schroedinger.engr.sgi.com>
Content-Type: text/plain
Message-Id: <1092729699.9539.131.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 17 Aug 2004 18:01:39 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Is this the _PAGE_BUSY bit? The pte update routines on PPC64 seem to spin
> on that bit when it is set waiting for the hash value update to complete.
> Looks very specific to the PPC64 architecture.

Yes, it is, I was thinking it's use could be extended tho

Ben.


