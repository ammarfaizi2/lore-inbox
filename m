Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWITRa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWITRa6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 13:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbWITRa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 13:30:58 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:33513 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932105AbWITRav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 13:30:51 -0400
Date: Wed, 20 Sep 2006 10:30:36 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: rohitseth@google.com, pj@sgi.com,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, devel@openvz.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [patch00/05]: Containers(V2)- Introduction
In-Reply-To: <45117830.3080909@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0609201024310.31178@schroedinger.engr.sgi.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
 <4510D3F4.1040009@yahoo.com.au> <Pine.LNX.4.64.0609200925280.30572@schroedinger.engr.sgi.com>
 <451172AB.2070103@yahoo.com.au> <Pine.LNX.4.64.0609201006420.30793@schroedinger.engr.sgi.com>
 <45117830.3080909@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006, Nick Piggin wrote:

> Patch 2/5 in this series provides hooks, and they are pretty unintrusive.

Ok. We shadow existing vm counters add stuff to the adress_space 
structure. The task add / remove is duplicating what some of the cpuset 
hooks do. That clearly shows that we are just duplicating functionality.

The mapping things are new.
