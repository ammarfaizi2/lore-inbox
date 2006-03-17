Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030245AbWCQSLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245AbWCQSLh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 13:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030248AbWCQSLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 13:11:37 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:58510 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030249AbWCQSLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 13:11:36 -0500
Date: Fri, 17 Mar 2006 10:11:28 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Hugh Dickins <hugh@veritas.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Race in pagevec_strip?
In-Reply-To: <Pine.LNX.4.61.0603171757270.643@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.64.0603171011090.9861@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0603161033120.2395@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0603161056270.2518@schroedinger.engr.sgi.com>
 <Pine.LNX.4.61.0603161934220.24837@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0603162000380.25033@goblin.wat.veritas.com>
 <Pine.LNX.4.64.0603161644510.4748@schroedinger.engr.sgi.com>
 <Pine.LNX.4.61.0603171757270.643@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Mar 2006, Hugh Dickins wrote:

> Anyway, I don't disagree with your patch, and happy to see it now
> in Linus' tree: was just wanting to make clear that I hadn't actually
> seen the race in question, and didn't know if you were fixing a
> potentiality or something actually seen.

Seems that some of our engineers have been chasing that one for awhile.

