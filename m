Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbVGLGcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVGLGcI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 02:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVGLGcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 02:32:08 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:26333 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261171AbVGLGcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 02:32:06 -0400
Subject: Re: [PATCH] [12/48] Suspend2 2.1.9.8 for 2.6.12:
	402-mtrr-remove-sysdev.patch
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Christoph Hellwig <hch@infradead.org>
Cc: Nigel Cunningham <nigel@suspend2.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050710230725.GE513@infradead.org>
References: <11206164393426@foobar.com> <11206164401476@foobar.com>
	 <20050710230725.GE513@infradead.org>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1121150031.13869.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 12 Jul 2005 16:33:51 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2005-07-11 at 09:07, Christoph Hellwig wrote:
> So what's this deep magic doing?  And why do you add such crude function for
> debug pagealloc builds only?

For debug_pagealloc, the pages we want to save and restore need to be
mapped for the the atomic copy, and unmapped afterwards. This function
achieves that.

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

