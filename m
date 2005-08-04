Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262647AbVHDSXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262647AbVHDSXr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 14:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbVHDSXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 14:23:40 -0400
Received: from palrel10.hp.com ([156.153.255.245]:6862 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S262534AbVHDSXd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 14:23:33 -0400
Date: Thu, 4 Aug 2005 11:26:52 -0700
From: Grant Grundler <iod00d@hp.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] Re: [RFC] Move InfiniBand .h files
Message-ID: <20050804182652.GF20422@esmail.cup.hp.com>
References: <52iryla9r5.fsf@cisco.com> <1123178038.3318.40.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123178038.3318.40.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2005 at 07:53:58PM +0200, Arjan van de Ven wrote:
> On Thu, 2005-08-04 at 10:32 -0700, Roland Dreier wrote:
> > I would like to get people's reactions to moving the InfiniBand .h
> > files from their current location in drivers/infiniband/include/ to
> > include/linux/rdma/.  If we agree that this is a good idea then I'll
> > push this change as soon as 2.6.14 starts.
> 
> please only put userspace clean headers here; the rest is more or less
> private headers for your subsystem. 

Sorry...this smells like a rathole...but does this mean
linus agrees the kernel subsystems should export headers suitable for
both user space and kernel driver modules?

Historical, I thought glibc and other user space libs were expected to
maintain their own set of header files. Maybe I'm just confused...

thanks,
grant
