Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265137AbUFAQdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265137AbUFAQdA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 12:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265161AbUFAQc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 12:32:59 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:31717 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S265155AbUFAQcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 12:32:13 -0400
Date: Tue, 1 Jun 2004 17:31:00 +0100
From: Dave Jones <davej@redhat.com>
To: Christoph Hellwig <hch@infradead.org>, Matt Domsch <Matt_Domsch@dell.com>,
       linux-kernel@vger.kernel.org
Subject: Re: intel-agp: skip non-AGP devices
Message-ID: <20040601163100.GC1265@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matt Domsch <Matt_Domsch@dell.com>, linux-kernel@vger.kernel.org
References: <20040601160457.GA11437@lists.us.dell.com> <20040601162058.GA20983@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040601162058.GA20983@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2004 at 05:20:58PM +0100, Christoph Hellwig wrote:

 > > The patch below checks for a valid cap_ptr prior to printing the
 > > message, now at KERN_WARNING level (it's not really an error, is it?)
 > 
 > The real problem is that agpgart doesn't properly fill in the pci_id
 > table but claims all devices and then does it's own probing internally.
 > This also breaks hotplug in a funny way.

This is fixed in agpgart-bk / -mm.  Andi went through all the drivers
adding their id's.  Should be going to Linus soon.

		Dave

