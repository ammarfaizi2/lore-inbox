Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751408AbWFPOKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbWFPOKK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 10:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbWFPOKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 10:10:10 -0400
Received: from tayrelbas04.tay.hp.com ([161.114.80.247]:13708 "EHLO
	tayrelbas04.tay.hp.com") by vger.kernel.org with ESMTP
	id S1751408AbWFPOKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 10:10:08 -0400
Date: Fri, 16 Jun 2006 07:02:34 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Cc: systemtap@sources.redhat.com, wcohen@redhat.com, perfmon@napali.hpl.hp.com
Subject: Re: [PATCH 9/16] 2.6.17-rc6 perfmon2 patch for review: kernel-level API support (kapi)
Message-ID: <20060616140234.GI10034@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200606150907.k5F97coF008178@frankl.hpl.hp.com> <20060616135014.GB12657@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060616135014.GB12657@infradead.org>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 16, 2006 at 02:50:14PM +0100, Christoph Hellwig wrote:
> On Thu, Jun 15, 2006 at 02:07:38AM -0700, Stephane Eranian wrote:
> > This patch contains the kernel-level API support.
> 
> NACK.  No one should call this from kernel space.
> 

Well, that's what I initially thought too but there is a need from the SystemTap
people and given the way they set things up, it is hard to do it from user level.

> and apparently noting in your patchkit does either, so this is just dead code.

I have not immediate need my self, but I have received several requests for
this, systemtap being one of them.

-- 
-Stephane
