Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266343AbUAHTy2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 14:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265780AbUAHTve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 14:51:34 -0500
Received: from ns1.s2io.com ([216.209.86.101]:15047 "EHLO ns1.s2io.com")
	by vger.kernel.org with ESMTP id S266323AbUAHTuR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 14:50:17 -0500
From: "Leonid Grossman" <leonid.grossman@s2io.com>
To: "'Christoph Hellwig'" <hch@infradead.org>
Cc: "'Grant Grundler'" <grundler@parisc-linux.org>,
       "'Jesse Barnes'" <jbarnes@sgi.com>, <linux-kernel@vger.kernel.org>,
       <jeremy@sgi.com>, "'Matthew Wilcox'" <willy@debian.org>,
       <linux-pci@atrey.karlin.mff.cuni.cz>, <Jame.Bottomley@steeleye.com>
Subject: RE: [RFC] Relaxed PIO read vs. DMA write ordering
Date: Thu, 8 Jan 2004 11:48:38 -0800
Message-ID: <00a201c3d620$6ede3620$0400a8c0@S2IOtech.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <20040108175422.A13247@infradead.org>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Spam-Score: -106.2
X-Spam-Outlook-Score: ()
X-Spam-Features: BAYES_01,IN_REP_TO,QUOTED_EMAIL_TEXT,USER_IN_WHITELIST
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@infradead.org] 
> Sent: Thursday, January 08, 2004 9:54 AM
> To: Leonid Grossman
> Cc: 'Grant Grundler'; 'Jesse Barnes'; 
> linux-kernel@vger.kernel.org; jeremy@sgi.com; 'Matthew 
> Wilcox'; linux-pci@atrey.karlin.mff.cuni.cz; 
> Jame.Bottomley@steeleye.com
> Subject: Re: [RFC] Relaxed PIO read vs. DMA write ordering
> 
> 
> On Thu, Jan 08, 2004 at 08:23:49AM -0800, Leonid Grossman wrote:
> > Yes, this is exactly how (at least our 10GbE) PCI-X ASICs 
> work. If the 
> > RO bit is set, the device decides whether the transaction requires 
> > strong ordering, and sets RO attribute accordingly.
> 
> Do you have a pointer to the driver source?  This would 
> probably make a good reference driver for Jesse's suggestion.
> 

Right now the code goes to our OEMs and end-user customers along with
the cards; 
We are planning to submit the driver to 2.6 kernel in about 
3 weeks or so. 
At that point we will also 'unmask' it on s2io ftp site for downloads.

Leonid

