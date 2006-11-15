Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162027AbWKOWqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162027AbWKOWqF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 17:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162029AbWKOWqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 17:46:05 -0500
Received: from dvhart.com ([64.146.134.43]:4250 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1162027AbWKOWqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 17:46:03 -0500
Message-ID: <455B98AA.3040904@mbligh.org>
Date: Wed, 15 Nov 2006 14:46:02 -0800
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
Cc: Christian Krafft <krafft@de.ibm.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2/2] enables booting a NUMA system where some nodes have
 no memory
References: <20061115193049.3457b44c@localhost> <20061115193437.25cdc371@localhost> <Pine.LNX.4.64.0611151323330.22074@schroedinger.engr.sgi.com> <455B8F3A.6030503@mbligh.org> <Pine.LNX.4.64.0611151440400.23201@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0611151440400.23201@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Wed, 15 Nov 2006, Martin Bligh wrote:
> 
>> A node is an arbitrary container object containing one or more of:
>>
>> CPUs
>> Memory
>> IO bus
>>
>> It does not have to contain memory.
> 
> I have never seen a node on Linux without memory. I have seen nodes 
> without processors and without I/O but not without memory.This seems to be 
> something new?

A node was always defined that way. Search back a few years in the lkml
archives. We may be finding bugs in the implementation, but the
definition has not changed.

Supposing we hot-unplugged all the memory in a node? Or seems to have
happened in this instance is boot with mem=, cutting out memory on that
node.

M.

