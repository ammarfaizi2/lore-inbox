Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbWBXBRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbWBXBRs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 20:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWBXBRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 20:17:47 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:31199 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932369AbWBXBRq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 20:17:46 -0500
Date: Thu, 23 Feb 2006 17:17:28 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: alokk@calsoftinc.com, manfred@colorfullife.com, penberg@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: Slab: Node rotor for freeing alien caches and remote per cpu
 pages.
In-Reply-To: <20060223165959.7b4310e4.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0602231716300.17963@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0602231036480.13184@schroedinger.engr.sgi.com>
 <20060223165959.7b4310e4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Feb 2006, Andrew Morton wrote:

> Should it be testing populated_zone() in there?

setup_pageset() is called for all zones for each cpu. So all pcps
of online nodes should be initialized properly.
