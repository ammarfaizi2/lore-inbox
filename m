Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265241AbUFHQ0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265241AbUFHQ0N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 12:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbUFHQ0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 12:26:13 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:59281 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S265241AbUFHQ0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 12:26:12 -0400
Date: Tue, 8 Jun 2004 17:25:42 +0100
From: Dave Jones <davej@redhat.com>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: intel-agp: skip non-AGP devices
Message-ID: <20040608162542.GH3642@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Matt Domsch <Matt_Domsch@dell.com>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
References: <20040601160457.GA11437@lists.us.dell.com> <20040601162058.GA20983@infradead.org> <20040601163100.GC1265@redhat.com> <20040608160027.GA13214@lists.us.dell.com> <20040608161745.GA13973@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040608161745.GA13973@lists.us.dell.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2004 at 11:17:45AM -0500, Matt Domsch wrote:

 > agpgart-bk and -mm didn't add proper PCI ID lists to sworks-agp.c (yet
 > I assume).  Patch below does the same for this as I submitted for
 > Intel previously.  It only prints a warning now if the device is AGP
 > capable but unrecognized.

Cool, thanks Matt. I'll look over the other drivers to double check.

		Dave


