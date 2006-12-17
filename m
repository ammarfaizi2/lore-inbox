Return-Path: <linux-kernel-owner+w=401wt.eu-S1752802AbWLQPTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802AbWLQPTH (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 10:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752800AbWLQPTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 10:19:07 -0500
Received: from taurus.voltaire.com ([193.47.165.240]:11884 "EHLO
	taurus.voltaire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752802AbWLQPTG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 10:19:06 -0500
X-Greylist: delayed 854 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Dec 2006 10:19:06 EST
Date: Sun, 17 Dec 2006 17:04:45 +0200
To: hjk@linutronix.de
Cc: linux-kernel@vger.kernel.org
Subject: uio and DMA memory allocations
Message-ID: <20061217150445.GC11360@minantech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
From: glebn@voltaire.com (Gleb Natapov)
X-OriginalArrivalTime: 17 Dec 2006 15:04:46.0014 (UTC) FILETIME=[B07A1DE0:01C721EC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

   Will it be possible to allocate DMAable memory using uio framework
(currently it isn't as far as I see).  More specifically if a driver needs
memory allocated with dma_alloc_coherent() will it be possible to allocate
it and map into userspace using uio?

--
			Gleb.
