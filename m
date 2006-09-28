Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751806AbWI1Jdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806AbWI1Jdi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 05:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751807AbWI1Jdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 05:33:38 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:39847 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751806AbWI1Jdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 05:33:37 -0400
Date: Thu, 28 Sep 2006 12:33:32 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Jim Paradis <jparadis@redhat.com>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86[-64] PCI domain support
Message-ID: <20060928093332.GG22787@rhun.haifa.ibm.com>
References: <20060926191508.GA6350@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060926191508.GA6350@havoc.gtf.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2006 at 03:15:08PM -0400, Jeff Garzik wrote:
> 
> The x86[-64] PCI domain effort needs to be restarted, because we've got
> machines out in the field that need this in order for some devices to
> work.
> 
This breaks the Calgary IOMMU, since it uses sysdata for other
purposes (going back from a bus to its IO address space). I'm looking
into it.

Cheers,
Muli

