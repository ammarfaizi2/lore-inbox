Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031014AbWKOWv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031014AbWKOWv5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 17:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031016AbWKOWv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 17:51:57 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:27366 "EHLO omx1.sgi.com")
	by vger.kernel.org with ESMTP id S1031014AbWKOWv4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 17:51:56 -0500
Date: Wed, 15 Nov 2006 14:51:26 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Martin Bligh <mbligh@mbligh.org>
cc: Christian Krafft <krafft@de.ibm.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2/2] enables booting a NUMA system where some nodes have
 no memory
In-Reply-To: <455B98AA.3040904@mbligh.org>
Message-ID: <Pine.LNX.4.64.0611151450550.23477@schroedinger.engr.sgi.com>
References: <20061115193049.3457b44c@localhost> <20061115193437.25cdc371@localhost>
 <Pine.LNX.4.64.0611151323330.22074@schroedinger.engr.sgi.com>
 <455B8F3A.6030503@mbligh.org> <Pine.LNX.4.64.0611151440400.23201@schroedinger.engr.sgi.com>
 <455B98AA.3040904@mbligh.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006, Martin Bligh wrote:

> Supposing we hot-unplugged all the memory in a node? Or seems to have
> happened in this instance is boot with mem=, cutting out memory on that
> node.

So a node with no memory has a pgdat_list structure but no zones? Or empty 
zones?
