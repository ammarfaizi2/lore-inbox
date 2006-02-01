Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422891AbWBAT1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422891AbWBAT1P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 14:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422888AbWBAT1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 14:27:15 -0500
Received: from fmr23.intel.com ([143.183.121.15]:41928 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1422885AbWBAT1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 14:27:14 -0500
Message-Id: <200602011925.k11JPYg22845@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Russell King'" <rmk+lkml@arm.linux.org.uk>
Cc: "'Christoph Hellwig'" <hch@infradead.org>,
       "'Akinobu Mita'" <mita@miraclelinux.com>,
       "Grant Grundler" <iod00d@hp.com>,
       "Linux Kernel Development" <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>
Subject: RE: [PATCH 1/12] generic *_bit()
Date: Wed, 1 Feb 2006 11:25:25 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcYnZL96AVMivZZ2Tby7xMvdOfwcYgAABibw
In-Reply-To: <20060201191957.GG3072@flint.arm.linux.org.uk>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote on Wednesday, February 01, 2006 11:20 AM
> > I think these should be defined to operate on arrays of unsigned int.
> > Bit is a bit, no matter how many byte you load (8/16/32/64), you can
> > only operate on just one bit.
> 
> Invalid assumption, from the point of view of endianness across different
> architectures.  Consider where bit 0 is for a LE and BE unsigned long *
> vs a LE and BE unsigned char *.

Where the bit end up in LE or BE is irrelevant. As long as one always
use the same bit numbering and same address pointer type, you always
get the same bit.  Or am I missing something?

- Ken

