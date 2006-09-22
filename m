Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964840AbWIVSJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbWIVSJA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 14:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbWIVSI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 14:08:59 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:19899 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964840AbWIVSI7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 14:08:59 -0400
Date: Fri, 22 Sep 2006 11:08:14 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Jesse Barnes <jesse.barnes@intel.com>
cc: Martin Bligh <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Rohit Seth <rohitseth@google.com>
Subject: Re: ZONE_DMA
In-Reply-To: <200609221039.28436.jesse.barnes@intel.com>
Message-ID: <Pine.LNX.4.64.0609221107440.8037@schroedinger.engr.sgi.com>
References: <20060920135438.d7dd362b.akpm@osdl.org>
 <Pine.LNX.4.64.0609211937460.4433@schroedinger.engr.sgi.com>
 <200609221021.16579.jesse.barnes@intel.com> <200609221039.28436.jesse.barnes@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006, Jesse Barnes wrote:

> Ok and right after I sent this my brain returned from vacation and I 
> remembered jejb's DMA allocation API.  It's powerful enough to cover most 
> driver use cases I think (users of GFP_DMA should probably be converted), 
> but for example block layer bounce buffering might need a different 
> interface as I see you've proposed in another mail.

Could you dig that out and give us some refs or even better port that 
thing to a current mm tree?
