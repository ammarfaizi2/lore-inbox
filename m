Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964967AbWIWA0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbWIWA0F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 20:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964970AbWIWA0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 20:26:05 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:4783 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964967AbWIWA0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 20:26:02 -0400
Date: Fri, 22 Sep 2006 17:25:50 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Martin Bligh <mbligh@mbligh.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       akpm@google.com, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       James Bottomley <James.Bottomley@steeleye.com>, linux-mm@kvack.org
Subject: Re: More thoughts on getting rid of ZONE_DMA
In-Reply-To: <200609230134.45355.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0609221724580.10484@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0609212052280.4736@schroedinger.engr.sgi.com>
 <4514441E.70207@mbligh.org> <Pine.LNX.4.64.0609221321280.9181@schroedinger.engr.sgi.com>
 <200609230134.45355.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another solution may be to favor high adresses in the page allocator?

