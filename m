Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269261AbUIHSEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269261AbUIHSEz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 14:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269267AbUIHSEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 14:04:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47336 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269261AbUIHSEx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 14:04:53 -0400
Date: Wed, 8 Sep 2004 14:04:31 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Ray Bryant <raybry@sgi.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
       <piggin@cyberone.com.au>
Subject: Re: swapping and the value of /proc/sys/vm/swappiness
In-Reply-To: <5860000.1094664673@flay>
Message-ID: <Pine.LNX.4.44.0409081403500.23362-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Sep 2004, Martin J. Bligh wrote:

> For HPC, maybe. For a fileserver, it might be far too little. That's the
> trouble ... it's all dependant on the workload. Personally, I'd prefer
> to get rid of manual tweakables (which are a pain in the ass in the field
> anyway), and try to have the kernel react to what the customer is doing.

Agreed.  Many of these things should be self-tunable pretty
easily, too...


-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan


