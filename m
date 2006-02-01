Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422902AbWBATjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422902AbWBATjR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 14:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422899AbWBATjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 14:39:17 -0500
Received: from palrel10.hp.com ([156.153.255.245]:63116 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S1422898AbWBATjQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 14:39:16 -0500
Date: Wed, 1 Feb 2006 11:39:33 -0800
From: Grant Grundler <iod00d@hp.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Christoph Hellwig'" <hch@infradead.org>,
       "'Akinobu Mita'" <mita@miraclelinux.com>,
       Grant Grundler <iod00d@hp.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH 1/12] generic *_bit()
Message-ID: <20060201193933.GA16471@esmail.cup.hp.com>
References: <20060201180237.GA18464@infradead.org> <200602011807.k11I7ag15563@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602011807.k11I7ag15563@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2006 at 10:07:28AM -0800, Chen, Kenneth W wrote:
> I think these should be defined to operate on arrays of unsigned int.
> Bit is a bit, no matter how many byte you load (8/16/32/64), you can
> only operate on just one bit.

Well, if it doesn't matter, why is unsigned int better?

unsigned long is typically the native register size, right?
I'd expect that to be more efficient on most arches.

grant
