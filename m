Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263276AbTHVNAw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 09:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263180AbTHVMuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 08:50:10 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:26637 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263189AbTHVMI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 08:08:28 -0400
Date: Fri, 22 Aug 2003 13:08:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Vinay K Nallamothu <vinay-rc@naturesoft.net>
Cc: linux-pcmcia@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.0-test3][PCMCIA] vx_entry.c: remove release timer
Message-ID: <20030822130826.A15033@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Vinay K Nallamothu <vinay-rc@naturesoft.net>,
	linux-pcmcia@lists.infradead.org,
	LKML <linux-kernel@vger.kernel.org>
References: <1061555067.1108.19.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1061555067.1108.19.camel@lima.royalchallenge.com>; from vinay-rc@naturesoft.net on Fri, Aug 22, 2003 at 05:54:27PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 22, 2003 at 05:54:27PM +0530, Vinay K Nallamothu wrote:
> sound/pcmcia/vx/vx_entry.c:
> This patch removes the PCMCIA timer release functionality which is no
> longer required. Without this the module can not be compiled and
> generates the following compiler error:

Sorry for missing that one, but I'm sure this will happen again to me
and other if the sound drivers stay outside drivers/.

