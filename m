Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbTJGPRK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 11:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbTJGPRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 11:17:10 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:22463 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S262420AbTJGPRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 11:17:07 -0400
Date: Tue, 7 Oct 2003 11:16:35 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Jaroslav Kysela <perex@suse.cz>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, <andrea@suse.com>,
       <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] memory counting fix
In-Reply-To: <Pine.LNX.4.44.0310071141270.23760-100000@logos.cnet>
Message-ID: <Pine.LNX.4.44.0310071114470.31052-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Oct 2003, Marcelo Tosatti wrote:

> But to the more basic question: Is the non-accounting of reserved pages
> desired?

I think it is useful to see how much pageable memory a
process is taking, being able to see how much pressure
it is putting on the VM, enforcing RSS ulimits only on
pageable memory, etc...

Accounting reserved pages too might confuse things...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

