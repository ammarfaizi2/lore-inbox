Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946049AbWBORcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946049AbWBORcs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 12:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946050AbWBORcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 12:32:48 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:53683 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1946049AbWBORcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 12:32:47 -0500
Subject: Re: [RFT/PATCH] 3c509: use proper suspend/resume API
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <20060215124020.GA1508@flint.arm.linux.org.uk>
References: <1139935173.22151.2.camel@localhost>
	 <20060215022523.1d21b9c9.akpm@osdl.org>
	 <Pine.LNX.4.58.0602151317110.14223@sbz-30.cs.Helsinki.FI>
	 <20060215124020.GA1508@flint.arm.linux.org.uk>
Date: Wed, 15 Feb 2006 19:32:45 +0200
Message-Id: <1140024765.24898.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 01:23:19PM +0200, Pekka J Enberg wrote:
> > Hmm. Either I am totally confused or we don't even attempt suspend/resume 
> > for eisa and mca bus devices. Care to try this patch?

On Wed, 2006-02-15 at 12:40 +0000, Russell King wrote:
> Please don't use struct device_driver suspend/resume methods.

So what would be more appropriate? Move suspend/resume/probe and friends
to eisa_driver and mca_driver?

			Pekka

