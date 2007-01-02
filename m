Return-Path: <linux-kernel-owner+w=401wt.eu-S932888AbXABSZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932888AbXABSZ6 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 13:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932730AbXABSZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 13:25:58 -0500
Received: from mga02.intel.com ([134.134.136.20]:9781 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932888AbXABSZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 13:25:57 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,227,1165219200"; 
   d="scan'208"; a="180705329:sNHT30064678"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Zach Brown'" <zach.brown@oracle.com>,
       "Christoph Hellwig" <hch@infradead.org>
Cc: "Andrew Morton" <akpm@osdl.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: RE: [patch] remove redundant iov segment check
Date: Tue, 2 Jan 2007 10:25:55 -0800
Message-ID: <000601c72e9b$717f86a0$ff0da8c0@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccumupxbKgKfzvEQL++xYbhofQWNwAABODA
In-Reply-To: <712B05B5-F7E2-4F19-9980-2CA95C5D15AC@oracle.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zach Brown wrote on Tuesday, January 02, 2007 10:22 AM
> >> I wonder if it wouldn't be better to make this change as part of a
> >> larger change that moves towards an explicit iovec container struct
> >> rather than bare 'struct iov *' and 'nr_segs' arguments.
> 
> > I suspect it should be rather trivial to get this started.  As a first
> > step we simply add a
> >
> > struct iodesc {
> > 	int nr_segs;
> > 	struct iovec ioc[]
> > };
> 
> Agreed, does anyone plan to try this in the near future?

Yes, I will take a stab at it this week.

