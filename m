Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbTD2MXF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 08:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbTD2MXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 08:23:04 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:2835 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261876AbTD2MXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 08:23:00 -0400
Date: Tue, 29 Apr 2003 13:35:16 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Chandrasekhar <chandrasekhar.nagaraj@patni.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Stack Trace dump in do_IRQ
Message-ID: <20030429133516.A29248@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Chandrasekhar <chandrasekhar.nagaraj@patni.com>,
	linux-kernel@vger.kernel.org
References: <NHBBIPBFKBJLCPPIPIBCCEAICAAA.chandrasekhar.nagaraj@patni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <NHBBIPBFKBJLCPPIPIBCCEAICAAA.chandrasekhar.nagaraj@patni.com>; from chandrasekhar.nagaraj@patni.com on Tue, Apr 29, 2003 at 06:04:28PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 29, 2003 at 06:04:28PM +0530, Chandrasekhar wrote:
> Hi All,
> We have a custom driver which runs on Red Hat Advanced Server 2.1(kernel
> version 2.4.9-e.3).

In general please report bugs for vendor kernels to their repective
vnedors - the RH AS kernels have forked from mainline 2.4 more than 1 1/2
years ago so they are very different from any official kernel.

> dont have the same check? Also, if the stack overflow can cause future
> problems, then
> how can we increase the stack size? Thanks in advance for any information on
> this.

I'd suggest fixing the driver instead :)  and btw, a similar debugging
check is merged in recent mainline kernels.

