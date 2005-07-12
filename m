Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVGLJFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVGLJFG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 05:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbVGLJFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 05:05:05 -0400
Received: from [203.171.93.254] ([203.171.93.254]:53632 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261259AbVGLJD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 05:03:26 -0400
Subject: Re: [PATCH] [10/48] Suspend2 2.1.9.8 for 2.6.12:
	360-reset-kswapd-max-order-after-resume.patch
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Christoph Hellwig <hch@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050710230901.GG513@infradead.org>
References: <11206164393426@foobar.com> <11206164403365@foobar.com>
	 <20050710230901.GG513@infradead.org>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1121159108.13869.133.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 12 Jul 2005 19:05:08 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-11 at 09:09, Christoph Hellwig wrote:
> So what is this doing, and is it breaking swsusp support?

Marking at boot time pages that shouldn't be saved. I'm not sure why
Pavel doesn't seem to need it. None of these changes break Pavel's code.

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

