Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269498AbUIZFdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269498AbUIZFdX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 01:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269494AbUIZFdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 01:33:23 -0400
Received: from gate.crashing.org ([63.228.1.57]:27268 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269498AbUIZFdW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 01:33:22 -0400
Subject: Re: ptep_establish/establish_pte needs set_pte_atomic and all
	set_pte must be written in asm
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Rik van Riel <riel@redhat.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040926013637.GU3309@dualathlon.random>
References: <20040926002037.GP3309@dualathlon.random>
	 <Pine.LNX.4.44.0409252030260.28582-100000@chimarrao.boston.redhat.com>
	 <20040926004608.GS3309@dualathlon.random>
	 <1096160383.18233.67.camel@gaston>
	 <20040926013637.GU3309@dualathlon.random>
Content-Type: text/plain
Message-Id: <1096176717.576.295.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 26 Sep 2004 15:31:58 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-09-26 at 11:36, Andrea Arcangeli wrote:

> the only one not volatile, or can you find more?

I'm not sure all DMA descriptor buffers are marked volatile but yes,
I tend to agree with you on the fact that it may be a good idea

Ben.


