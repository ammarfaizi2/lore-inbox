Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbUDAToL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 14:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263114AbUDAToL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 14:44:11 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:1033 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262813AbUDAToJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 14:44:09 -0500
Date: Thu, 1 Apr 2004 20:44:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Sridhar Samudrala <sri@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_DEBUG_PAGEALLOC and virt_addr_valid()
Message-ID: <20040401204407.A24608@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Sridhar Samudrala <sri@us.ibm.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0404011105120.1956@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0404011105120.1956@localhost.localdomain>; from sri@us.ibm.com on Thu, Apr 01, 2004 at 11:11:39AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 11:11:39AM -0800, Sridhar Samudrala wrote:
> When CONFIG_DEBUG_PAGEALLOC is enabled, i am noticing that virt_addr_valid()
> (called from sctp_is_valid_kaddr()) is returning true even for freed objects.
> Is this a bug or expected behavior?

Generally every use of virt_addr_valid() is a bug.  What are you trying to
do?

