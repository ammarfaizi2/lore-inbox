Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270181AbUJTJnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270181AbUJTJnP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 05:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270276AbUJTJiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 05:38:10 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:41192 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S270057AbUJTJcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 05:32:41 -0400
Date: Wed, 20 Oct 2004 02:31:40 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Anton Blanchard <anton@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: New consolidate irqs vs . probe_irq_*()
Message-ID: <20041020093140.GA27119@taniwha.stupidest.org>
References: <16758.3807.954319.110353@cargo.ozlabs.ibm.com> <20041020083358.GB23396@elte.hu> <1098261745.6263.9.camel@gaston> <20041020084838.GA25798@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020084838.GA25798@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 10:48:38AM +0200, Ingo Molnar wrote:

> yeah. I've put it into a separate autoprobe.c file specifically for
> that reason, you can exclude it in the Makefile and can provide your
> own architecture version. Or should we make the no-autoprobing
> choice generic perhaps?

UML could also use that since it doesn't need autoprobe.c strictly
speaking.
