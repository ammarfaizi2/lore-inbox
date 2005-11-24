Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161026AbVKXG5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161026AbVKXG5I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 01:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161025AbVKXG5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 01:57:08 -0500
Received: from mx1.netapp.com ([216.240.18.38]:56480 "EHLO mx1.netapp.com")
	by vger.kernel.org with ESMTP id S1161022AbVKXG5G convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 01:57:06 -0500
X-IronPort-AV: i="3.97,369,1125903600"; 
   d="scan'208"; a="268669740:sNHT18986760"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [2.6 patch] net/sunrpc/xdr.c: remove xdr_decode_string()
Date: Wed, 23 Nov 2005 22:56:51 -0800
Message-ID: <044B81DE141D7443BCE91E8F44B3C1E2013327ED@exsvl02.hq.netapp.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6 patch] net/sunrpc/xdr.c: remove xdr_decode_string()
Thread-Index: AcXwgq7lU+1OZJbPSW6N0YCO94ezTAAQV/4A
From: "Lever, Charles" <Charles.Lever@netapp.com>
To: "Neil Brown" <neilb@suse.de>, "Adrian Bunk" <bunk@stusta.de>
Cc: "David Miller" <davem@davemloft.net>, <trond.myklebust@fys.uio.no>,
       <linux-kernel@vger.kernel.org>, <nfs@lists.sourceforge.net>,
       <netdev@vger.kernel.org>
X-OriginalArrivalTime: 24 Nov 2005 06:56:51.0945 (UTC) FILETIME=[3F7EAD90:01C5F0C4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wednesday November 23, bunk@stusta.de wrote:
> > On Wed, Nov 23, 2005 at 04:31:14AM -0800, Lever, Charles wrote:
> > > so i don't remember why you are removing 
> xdr_decode_string.  are we sure
> > > that no-one will need this functionality in the future?  
> it is harmless
> > > to remove today, but i wonder if someone is just going to 
> add it back
> > > sometime.
> > 
> > It's unused and you said:
> >   the only harmless change i see below is removing 
> xdr_decode_string().
> > 
> 
> As 'xdr_decode_string' (sometimes) modifies the buffer that it is
> decoding, I don't think it's usage should be encouraged.  If it is no
> longer in use, then I fully support and encourage removing it.

actually this is a good point.  since it is unused, it is an untested
path as we continue to evolve the code base.
