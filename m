Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267473AbUIJPGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267473AbUIJPGk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 11:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267460AbUIJPGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 11:06:40 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:15026 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S267475AbUIJPG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 11:06:27 -0400
Date: Fri, 10 Sep 2004 08:06:18 -0700
From: Chris Wedgwood <cw@f00f.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, arjanv@redhat.com,
       LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
Message-ID: <20040910150618.GA4857@taniwha.stupidest.org>
References: <20040909232532.GA13572@taniwha.stupidest.org> <1094798428.2800.3.camel@laptop.fenrus.com> <1094807650.17041.3.camel@localhost.localdomain> <593560000.1094826651@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <593560000.1094826651@[10.10.2.4]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 07:30:52AM -0700, Martin J. Bligh wrote:

> What problems does it cause? 2.95.4 still seems to work fine for me.

Older (and even current) gcc's spill badly in some circumstances and
also fail to reuse / better-use spill/stack space.  It's been
suggested to me that gcc from CVS as of a week ago is much better (i
tried buidling it and didn't get far, I'll have to try again)
