Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030303AbVLFXkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030303AbVLFXkr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 18:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030305AbVLFXkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 18:40:47 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:54931 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030303AbVLFXkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 18:40:47 -0500
Date: Tue, 6 Dec 2005 15:40:41 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       linux-mm@kvack.org, Andi Kleen <ak@suse.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [RFC 1/3] Framework for accurate node based statistics
In-Reply-To: <Pine.LNX.4.62.0512061536001.20580@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.62.0512061539280.20618@schroedinger.engr.sgi.com>
References: <20051206182843.19188.82045.sendpatchset@schroedinger.engr.sgi.com>
 <439619F9.4030905@yahoo.com.au> <Pine.LNX.4.62.0512061536001.20580@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Dec 2005, Christoph Lameter wrote:

> I am not aware of any per-zone per cpu counters.

Argh. Wrong. Yes there are counters in the per cpu structures for each 
zone. The pointers here could be folded into that and then would give us 
zone based statistics which may be better than per node statistics for 
decision making about memory in a zone.

