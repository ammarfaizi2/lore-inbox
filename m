Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265244AbUFHQMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265244AbUFHQMK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 12:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265254AbUFHQMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 12:12:10 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:36497 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S265244AbUFHQMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 12:12:08 -0400
Date: Tue, 8 Jun 2004 17:10:54 +0100
From: Dave Jones <davej@redhat.com>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: intel-agp: skip non-AGP devices
Message-ID: <20040608161054.GG3642@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Matt Domsch <Matt_Domsch@dell.com>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
References: <20040601160457.GA11437@lists.us.dell.com> <20040601162058.GA20983@infradead.org> <20040601163100.GC1265@redhat.com> <20040608160027.GA13214@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040608160027.GA13214@lists.us.dell.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2004 at 11:00:27AM -0500, Matt Domsch wrote:

 > > This is fixed in agpgart-bk / -mm.  Andi went through all the drivers
 > > adding their id's.  Should be going to Linus soon.
 > 
 > FWIW, sworks-agp.c has the same issue in mainline yet today.
 > agpgart: Unsupported Serverworks chipset (device id: 0011) 
 > agpgart: Unsupported Serverworks chipset (device id: 0201) 
 > 
 > I'll look at -mm to verify it's fixed there.

Andi did all of the drivers iirc, and these changes are now
in mainline btw.

		Dave
