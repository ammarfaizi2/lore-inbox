Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755495AbWKUXaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755495AbWKUXaq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 18:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755499AbWKUXaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 18:30:46 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:19091 "EHLO omx1.sgi.com")
	by vger.kernel.org with ESMTP id S1755495AbWKUXap (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 18:30:45 -0500
Date: Tue, 21 Nov 2006 15:30:37 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Mel Gorman <mel@csn.ul.ie>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/11] Add __GFP_MOVABLE flag and update callers
In-Reply-To: <20061121225042.11710.15200.sendpatchset@skynet.skynet.ie>
Message-ID: <Pine.LNX.4.64.0611211529030.32283@schroedinger.engr.sgi.com>
References: <20061121225022.11710.72178.sendpatchset@skynet.skynet.ie>
 <20061121225042.11710.15200.sendpatchset@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are GFP_HIGHUSER allocations always movable? It would reduce the size of 
the patch if this would be added to GFP_HIGHUSER.


