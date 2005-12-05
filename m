Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932531AbVLETZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbVLETZM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 14:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932532AbVLETZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 14:25:12 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:20117 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932531AbVLETZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 14:25:10 -0500
Date: Mon, 5 Dec 2005 11:24:40 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Christoph Hellwig <hch@infradead.org>
cc: akpm@osdl.org, torvalds@osdl.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Arch specific zone reclaim framework
In-Reply-To: <20051205191159.GB28433@infradead.org>
Message-ID: <Pine.LNX.4.62.0512051122280.12133@schroedinger.engr.sgi.com>
References: <20051205190104.12037.69672.sendpatchset@schroedinger.engr.sgi.com>
 <20051205191159.GB28433@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Dec 2005, Christoph Hellwig wrote:

> Nack.  Arch control over VM reclaim logic will load to a total mess with VM
> logic all over arch.  Please introduce a framework that allows individual
> machines control parameters, but procedural callouts are a big no-no.

The different penalties for off node accesses on various architectures may 
dictate different techniques in order to get best performance . The 
parameter control was tried before and it was not nice. IMHO this is the 
cleanest possible solution.



