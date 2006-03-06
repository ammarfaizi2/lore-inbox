Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbWCFTVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbWCFTVf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 14:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbWCFTVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 14:21:35 -0500
Received: from mms3.broadcom.com ([216.31.210.19]:10505 "EHLO
	MMS3.broadcom.com") by vger.kernel.org with ESMTP id S932343AbWCFTVQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 14:21:16 -0500
X-Server-Uuid: B238DE4C-2139-4D32-96A8-DD564EF2313E
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [PATCH 2/6] IB: match connection requests based on private
 data
Date: Mon, 6 Mar 2006 11:20:57 -0800
Message-ID: <54AD0F12E08D1541B826BE97C98F99F12FBF19@NT-SJCA-0751.brcm.ad.broadcom.com>
Thread-Topic: [PATCH 2/6] IB: match connection requests based on private
 data
Thread-Index: AcY/FYSDoSObWDAKRKyl93Kwz34rUACOopXwAACiWiA=
From: "Caitlin Bestler" <caitlinb@broadcom.com>
To: "Sean Hefty" <sean.hefty@intel.com>, "Roland Dreier" <rdreier@cisco.com>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006030606; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413039303230342E34343043384231452E303039422D412D;
 ENG=IBF; TS=20060306192248; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006030606_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 6812538D36W4578260-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: netdev-owner@vger.kernel.org 
> [mailto:netdev-owner@vger.kernel.org] On Behalf Of Sean Hefty
> Sent: Monday, March 06, 2006 11:04 AM
> To: 'Roland Dreier'
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; 
> openib-general@openib.org
> Subject: [PATCH 2/6] IB: match connection requests based on 
> private data
> 
> Extend matching connection requests to listens in the 
> Infiniband CM to include private data checks.
> 
> This allows applications to listen on the same service 
> identifier, with private data directing the request to the 
> appropriate application.
> 
> Signed-off-by: Sean Hefty <sean.hefty@intel.com>
> 

The term "private data" is intended to convey the
intent that the data is private to the application
layer and is opaque to middleware and the network.

By what mechanism does the listening application
delegate how much of the private data for use by
the CM for sub-dividing a listen? What does an 
application do if it wishes to retain full ownership
of the private data?


