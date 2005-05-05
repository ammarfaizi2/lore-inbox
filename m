Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261894AbVEEFah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261894AbVEEFah (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 01:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbVEEFah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 01:30:37 -0400
Received: from ozlabs.org ([203.10.76.45]:907 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261894AbVEEFae (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 01:30:34 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17017.44939.872627.155191@cargo.ozlabs.ibm.com>
Date: Thu, 5 May 2005 15:30:51 +1000
From: Paul Mackerras <paulus@samba.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] move /proc/ppc_htab creating self-contained in arch/ppc/ code
In-Reply-To: <20050504184439.GA20671@lst.de>
References: <20050504184439.GA20671@lst.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:

> additional benefit is cleaning up the ifdef mess in ppc_htab.c

Hmmm, really /proc/ppc_htab should die, and we should put the PMCs,
L2CR and L3CR in sysfs (and/or use perfctr to get at the PMCs).  But
your patch looks ok as an interim measure.

Paul.
