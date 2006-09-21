Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbWIUAkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWIUAkZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 20:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbWIUAkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 20:40:25 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:16591 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750853AbWIUAkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 20:40:24 -0400
Date: Wed, 20 Sep 2006 17:40:20 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 -mm merge plans
In-Reply-To: <4511D855.7050100@mbligh.org>
Message-ID: <Pine.LNX.4.64.0609201739350.2518@schroedinger.engr.sgi.com>
References: <20060920135438.d7dd362b.akpm@osdl.org> <4511D855.7050100@mbligh.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006, Martin J. Bligh wrote:

> Would it not make sense to define what ZONE_DMA actually means
> consistently before trying to change it? The current mess across
> different architectures seems like a disaster area to me.

Actually the desaster is cleaned up by this patch. A couple of 
architectures that were wrongly using ZONE_DMA now use ZONE_NORMAL.
