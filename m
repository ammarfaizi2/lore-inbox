Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269206AbUIHXZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269206AbUIHXZP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 19:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269200AbUIHXYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 19:24:02 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12442 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269212AbUIHXXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 19:23:42 -0400
Date: Wed, 8 Sep 2004 19:22:11 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Diego Calleja <diegocg@teleline.es>, <raybry@sgi.com>,
       <marcelo.tosatti@cyclades.com>, <kernel@kolivas.org>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
       <piggin@cyberone.com.au>
Subject: Re: swapping and the value of /proc/sys/vm/swappiness
In-Reply-To: <50520000.1094682042@flay>
Message-ID: <Pine.LNX.4.44.0409081920500.5466-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Sep 2004, Martin J. Bligh wrote:

> Oh, I see what you mean. I think we're much better off sticking the
> mechanism for autotuning stuff in the kernel -

Agreed.  Autotuning like this appears to work best by having
a self adjusting algorithm, often negative feedback loops so
things get balanced out automagically.

Works way better than anything looking at indirect data and
then tweaking some magic knobs...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

