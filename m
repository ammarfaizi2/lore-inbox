Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWHWB27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWHWB27 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 21:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWHWB27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 21:28:59 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:53212 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932138AbWHWB26 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 21:28:58 -0400
Date: Wed, 23 Aug 2006 06:59:59 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, hch@infradead.org,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Jim Keniston <jkenisto@us.ibm.com>, davem@davemloft.net,
       schwidefsky@de.ibm.com
Subject: Re: [PATCH 2/3] Add retval_value helper (updated)
Message-ID: <20060823012959.GA7927@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <20060822052448.GA26279@in.ibm.com> <20060822052841.GB26279@in.ibm.com> <20060822141307.672850d7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060822141307.672850d7.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2006 at 02:13:07PM -0700, Andrew Morton wrote:
> On Tue, 22 Aug 2006 10:58:41 +0530
> Ananth N Mavinakayanahalli <ananth@in.ibm.com> wrote:
> 
> > From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> > 
> > Add the return_value() macro to extract the return value in an
> > architecture agnostic manner, given the pt_regs.
> > 
> > Other architecture maintainers may want to add similar helpers.
> 
> return_value() is quite a generic-sounding thing.
> 
> box:/usr/src/linux-2.6.18-rc4> grep -r return_value . | wc -l
> 66
> 
> 
> How about regs_return_value()?

Yes, that sounds fine too.

Ananth
