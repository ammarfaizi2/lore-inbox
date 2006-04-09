Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750924AbWDIT4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbWDIT4L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 15:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbWDIT4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 15:56:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:23481 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750821AbWDIT4K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 15:56:10 -0400
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] i386/x86-64: Return defined error value for bad PCI config space accesses
Date: Sun, 9 Apr 2006 21:55:34 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200604091900.k39J0uVn013016@hera.kernel.org> <44395DD2.8080700@garzik.org>
In-Reply-To: <44395DD2.8080700@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604092155.34488.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 April 2006 21:17, Jeff Garzik wrote:

> As the code check indicates, value might be NULL.
> 
> Please fix.

It should never be NULL.  If anything that's a BUG_ON, but crashing on it is ok
too. 

But I'll change it to a BUG_ON in the next patch thanks.

-Andi
