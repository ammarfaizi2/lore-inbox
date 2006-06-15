Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030739AbWFOP4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030739AbWFOP4y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 11:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030736AbWFOP4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 11:56:53 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:4748 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030737AbWFOP4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 11:56:52 -0400
Date: Thu, 15 Jun 2006 08:56:42 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
cc: akpm@osdl.org, ak@suse.de, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: light weight counters: race free through local_t?
In-Reply-To: <44915110.2050100@bull.net>
Message-ID: <Pine.LNX.4.64.0606150855410.9137@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0606092212200.4875@schroedinger.engr.sgi.com>
 <449033B0.1020206@bull.net> <Pine.LNX.4.64.0606140928500.4030@schroedinger.engr.sgi.com>
 <44915110.2050100@bull.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jun 2006, Zoltan Menyhart wrote:

> My conclusion: let's stick to atomic counters.

Good to know. But we would run into trouble if the atomic counters would 
be contended.


