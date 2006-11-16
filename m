Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162126AbWKPAqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162126AbWKPAqz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 19:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162127AbWKPAqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 19:46:54 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:52430 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1162126AbWKPAqx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 19:46:53 -0500
Date: Wed, 15 Nov 2006 16:46:22 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Martin Bligh <mbligh@mbligh.org>, Christian Krafft <krafft@de.ibm.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/2] enables booting a NUMA system where some nodes have
 no memory
In-Reply-To: <9a8748490611151644m5420fd9claf8212f98a6ad4e2@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0611151645500.24457@schroedinger.engr.sgi.com>
References: <20061115193049.3457b44c@localhost>  <20061115193437.25cdc371@localhost>
  <Pine.LNX.4.64.0611151323330.22074@schroedinger.engr.sgi.com> 
 <455B8F3A.6030503@mbligh.org>  <Pine.LNX.4.64.0611151440400.23201@schroedinger.engr.sgi.com>
 <9a8748490611151644m5420fd9claf8212f98a6ad4e2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2006, Jesper Juhl wrote:

> What about SMP Opteron boards that have RAM slots for each CPU?
> With two (or more) CPU's and only memory slots populated for one of
> them, wouldn't that count as multiple NUMA nodes but only one of them
> with memory?
> That would seem to be a pretty common thing that could happen.

I think so far we have handled these as two processors on one node.

