Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbTJGOi5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 10:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbTJGOi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 10:38:56 -0400
Received: from intra.cyclades.com ([64.186.161.6]:30366 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262363AbTJGOiz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 10:38:55 -0400
Date: Tue, 7 Oct 2003 11:41:54 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Rik van Riel <riel@redhat.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Jaroslav Kysela <perex@suse.cz>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, <andrea@suse.com>,
       <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] memory counting fix
In-Reply-To: <Pine.LNX.4.44.0310070850340.31052-100000@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.44.0310071141270.23760-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 Oct 2003, Rik van Riel wrote:

> On Tue, 7 Oct 2003, Marcelo Tosatti wrote:
> 
> > I dont see why reserved pages shouldnt be counted in the processes RSS.
> 
> Then you'll need to change about a dozen pieces of code
> all over the place ;)
> 
> > What I'm missing here, Jaroslav?
> 
> The rest of the kernel doesn't count reserved pages as
> part of the rss.  This patch seems to simply bring this
> piece of code into line with the rest.

Fine, applied.

But to the more basic question: Is the non-accounting of reserved pages 
desired? 

