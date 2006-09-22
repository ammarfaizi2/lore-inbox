Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbWIVRh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbWIVRh7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 13:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbWIVRh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 13:37:58 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:57520 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964819AbWIVRh6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 13:37:58 -0400
Date: Fri, 22 Sep 2006 10:37:45 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Martin Bligh <mbligh@mbligh.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Rohit Seth <rohitseth@google.com>, jesse.barnes@intel.com,
       anton@samba.org
Subject: Re: ZONE_DMA
In-Reply-To: <45141EE8.4030607@mbligh.org>
Message-ID: <Pine.LNX.4.64.0609221036510.7816@schroedinger.engr.sgi.com>
References: <20060920135438.d7dd362b.akpm@osdl.org> <4511D855.7050100@mbligh.org>
 <20060920172253.f6d11445.akpm@osdl.org> <4511E1CA.6090403@mbligh.org>
 <Pine.LNX.4.64.0609201804320.2844@schroedinger.engr.sgi.com>
 <4511E9AC.2050507@mbligh.org> <Pine.LNX.4.64.0609210854210.5626@schroedinger.engr.sgi.com>
 <4512C469.5060107@mbligh.org> <Pine.LNX.4.64.0609211045400.5959@schroedinger.engr.sgi.com>
 <45131D2D.8020403@mbligh.org> <Pine.LNX.4.64.0609211937460.4433@schroedinger.engr.sgi.com>
 <45141EE8.4030607@mbligh.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006, Martin Bligh wrote:

> However, whatever you do, meeting (2) is rather hard - it's a damned
> sight simpler to stuff it all in ZONE_DMA because that's the end of
> the fallback list.

That used to be the case. If you switch ZONE_DMA off (like possible in mm) 
then ZONE_NORMAL is the end of the fallback. I think we basically want 
the same thing and get to the same result.


