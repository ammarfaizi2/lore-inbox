Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266575AbUFQRAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266575AbUFQRAN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 13:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266576AbUFQRAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 13:00:13 -0400
Received: from ceiriog1.demon.co.uk ([194.222.75.230]:50816 "EHLO
	ceiriog1.demon.co.uk") by vger.kernel.org with ESMTP
	id S266575AbUFQRAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 13:00:09 -0400
Subject: Re: Irix NFS servers, again :-)
From: Peter Wainwright <prw@ceiriog1.demon.co.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040617134424.GA32272@infradead.org>
References: <1087411925.30092.35.camel@ceiriog1.demon.co.uk>
	 <20040617134424.GA32272@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1087491319.3677.5.camel@ceiriog1.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 17 Jun 2004 17:55:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-17 at 14:44, Christoph Hellwig wrote:
> On Wed, Jun 16, 2004 at 07:52:06PM +0100, Peter Wainwright wrote:
> > I just upgraded one of my machines to Fedora Core 2, including
> > kernel 2.6.5. I found myself bitten on the bum by a bug I thought
> > had expired long ago, namely the Irix server readdir bug, or
> > 32/64-bit cookie problem.
> > 
> > Therefore, I thought I should let you folks know that this problem
> > is still there, apparently.
> 
> IIRC this was fixed on the IRIX side a while ago.  What IRIX version
> do you run?
> 

Not very old, it's 6.5.21. And I do have -32bitclients
in my /etc/exports.

BTW, I just found an old patch I made for glibc 2.2 to
fix this (or a similar) problem. Maybe that's a better
place for a fix

Peter Wainwright
