Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262963AbUFQUlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262963AbUFQUlL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 16:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbUFQUlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 16:41:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29130 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262438AbUFQUlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 16:41:08 -0400
Date: Thu, 17 Jun 2004 16:38:42 -0400
From: Alan Cox <alan@redhat.com>
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>, y@redhat.com
Cc: Alan Cox <alan@redhat.com>, Clay Haapala <chaapala@cisco.com>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: PATCH: Further aacraid work
Message-ID: <20040617203842.GC8705@devserv.devel.redhat.com>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189FD2407B@otce2k03.adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <547AF3BD0F3F0B4CBDC379BAC7E4189FD2407B@otce2k03.adaptec.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2004 at 01:54:38PM -0400, Salyzyn, Mark wrote:
> And I might add, undoing the entropy to result in the descending page
> list (but that is the forth time I've said this).
> 
> I ran heavy sequential load overnight and continued to have this
> characteristic when taking snapshots of command SG lists. The average SG
> element size statistically was 4168 bytes.

What do the stats look like with the patch Andrew Morton (I think) posted
to reverse the page order from the allocator ?
