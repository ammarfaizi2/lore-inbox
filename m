Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWITRwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWITRwW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 13:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWITRwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 13:52:21 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:24798 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932172AbWITRwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 13:52:21 -0400
Date: Wed, 20 Sep 2006 10:52:12 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Rohit Seth <rohitseth@google.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, devel@openvz.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [patch00/05]: Containers(V2)- Introduction
In-Reply-To: <1158774657.8574.65.camel@galaxy.corp.google.com>
Message-ID: <Pine.LNX.4.64.0609201051550.31636@schroedinger.engr.sgi.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com> 
 <4510D3F4.1040009@yahoo.com.au> <1158751720.8970.67.camel@twins> 
 <4511626B.9000106@yahoo.com.au> <1158767787.3278.103.camel@taijtu> 
 <451173B5.1000805@yahoo.com.au> <1158774657.8574.65.camel@galaxy.corp.google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006, Rohit Seth wrote:

> Right now the memory handler in this container subsystem is written in
> such a way that when existing kernel reclaimer kicks in, it will first
> operate on those (container with pages over the limit) pages first.  But
> in general I like the notion of containerizing the whole reclaim code.

Which comes naturally with cpusets.
