Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751932AbWCJTNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932AbWCJTNP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 14:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752014AbWCJTNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 14:13:15 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:18600 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751932AbWCJTNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 14:13:14 -0500
Date: Fri, 10 Mar 2006 11:12:56 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Magnus Damm <magnus@valinux.co.jp>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH 00/03] Unmapped: Separate unmapped and mapped pages
In-Reply-To: <20060310034412.8340.90939.sendpatchset@cherry.local>
Message-ID: <Pine.LNX.4.64.0603101111570.28805@schroedinger.engr.sgi.com>
References: <20060310034412.8340.90939.sendpatchset@cherry.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2006, Magnus Damm wrote:

> Unmapped patches - Use two LRU:s per zone.

Note that if this is done then the default case of zone_reclaim becomes 
trivial to deal with and we can get rid of the zone_reclaim_interval.

However, I have not looked at the rest yet.

