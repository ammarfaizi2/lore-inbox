Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932701AbWCPUBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932701AbWCPUBp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 15:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932707AbWCPUBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 15:01:45 -0500
Received: from silver.veritas.com ([143.127.12.111]:8827 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932701AbWCPUBo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 15:01:44 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.02,198,1139212800"; 
   d="scan'208"; a="35989717:sNHT23660096"
Date: Thu, 16 Mar 2006 20:02:22 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Christoph Lameter <clameter@sgi.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Race in pagevec_strip?
In-Reply-To: <Pine.LNX.4.61.0603161934220.24837@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0603162000380.25033@goblin.wat.veritas.com>
References: <Pine.LNX.4.64.0603161033120.2395@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0603161056270.2518@schroedinger.engr.sgi.com>
 <Pine.LNX.4.61.0603161934220.24837@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 16 Mar 2006 20:01:43.0522 (UTC) FILETIME=[72871420:01C64934]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2006, Hugh Dickins wrote:
> 
> I can't see what protects the default drop_buffers case against this,
> so can't argue that it's an XFS problem.

But I should add, I don't see what might be racing with what on the
same page, to cause the problem in practice.

Hugh
