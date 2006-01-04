Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751498AbWADAtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbWADAtd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 19:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbWADAtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 19:49:32 -0500
Received: from mail.suse.de ([195.135.220.2]:62130 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751498AbWADAtb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 19:49:31 -0500
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix the zone reclaim code in 2.6.15
Date: Wed, 4 Jan 2006 01:50:15 +0100
User-Agent: KMail/1.8
Cc: Christoph Lameter <clameter@engr.sgi.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.62.0601031457300.22676@schroedinger.engr.sgi.com> <Pine.LNX.4.62.0601031556120.23039@schroedinger.engr.sgi.com> <20060103164351.658a75c7.akpm@osdl.org>
In-Reply-To: <20060103164351.658a75c7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601040150.15535.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 January 2006 01:43, Andrew Morton wrote:

> Your changelog didn't describe this as a "severe" problem.  Things have
> been like this for quite some time, haven't they?

I get at least regular complaints on x86-64 about it. It's not really a FAQ 
yet, but at least an issue multiple people run into.

-Andi
