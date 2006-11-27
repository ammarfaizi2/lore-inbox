Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758275AbWK0PIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758275AbWK0PIu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 10:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758274AbWK0PIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 10:08:49 -0500
Received: from cantor2.suse.de ([195.135.220.15]:65003 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1758275AbWK0PIs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 10:08:48 -0500
From: Andi Kleen <ak@suse.de>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH] Add debugging aid for memory initialisation problems
Date: Mon, 27 Nov 2006 16:08:34 +0100
User-Agent: KMail/1.9.5
Cc: akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20061127140804.GA15405@skynet.ie> <200611271514.03612.ak@suse.de> <Pine.LNX.4.64.0611271437560.15577@skynet.skynet.ie>
In-Reply-To: <Pine.LNX.4.64.0611271437560.15577@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611271608.34484.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > So how many new lines does that add overall?
> 
> I don't know for sure, but it's probably around the 150 LOC mark from 

Sorry I meant just dmesg foot print. I think before you add anything
new you first need a construct like apic_printk() with a configurable log level
with a low default.

-Andi
