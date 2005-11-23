Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbVKWMbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbVKWMbV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 07:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbVKWMbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 07:31:21 -0500
Received: from mx1.netapp.com ([216.240.18.38]:65080 "EHLO mx1.netapp.com")
	by vger.kernel.org with ESMTP id S1750723AbVKWMbU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 07:31:20 -0500
X-IronPort-AV: i="3.97,364,1125903600"; 
   d="scan'208"; a="268496617:sNHT19078104"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [2.6 patch] net/sunrpc/xdr.c: remove xdr_decode_string()
Date: Wed, 23 Nov 2005 04:31:14 -0800
Message-ID: <044B81DE141D7443BCE91E8F44B3C1E2013327DF@exsvl02.hq.netapp.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6 patch] net/sunrpc/xdr.c: remove xdr_decode_string()
Thread-Index: AcXvzKUhjuamXFI4TTuDsMLugDBwtgAXNY5A
From: "Lever, Charles" <Charles.Lever@netapp.com>
To: "Adrian Bunk" <bunk@stusta.de>
Cc: "David Miller" <davem@davemloft.net>, <neilb@cse.unsw.edu.au>,
       <trond.myklebust@fys.uio.no>, <linux-kernel@vger.kernel.org>,
       <nfs@lists.sourceforge.net>, <netdev@vger.kernel.org>
X-OriginalArrivalTime: 23 Nov 2005 12:31:14.0757 (UTC) FILETIME=[CB731750:01C5F029]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Oct 06, 2005 at 07:13:14AM -0700, Lever, Charles wrote:
> 
> > actually, can we hold off on this change?  the RPC 
> transport switch will
> > eventually need most of those EXPORT_SYMBOLs.
> 
> Am I right to assume this will happen in the foreseeable future?

the first portion of the transport switch is in 2.6.15-rcX.  at this
point i'm expecting the EXPORT_SYMBOL changes to go in 2.6.17 or later.

so i don't remember why you are removing xdr_decode_string.  are we sure
that no-one will need this functionality in the future?  it is harmless
to remove today, but i wonder if someone is just going to add it back
sometime.
