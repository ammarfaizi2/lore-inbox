Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbVGDK2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbVGDK2W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 06:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbVGDK1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 06:27:41 -0400
Received: from gold.veritas.com ([143.127.12.110]:8821 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S261394AbVGDK1J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 06:27:09 -0400
Date: Mon, 4 Jul 2005 11:28:12 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Christoph Hellwig <hch@infradead.org>
cc: Arjan van de Ven <arjan@infradead.org>, Denis Vlasenko <vda@ilport.com.ua>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       "cutaway@bellsouth.net" <cutaway@bellsouth.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Coywolf Qi Hunt <coywolf@gmail.com>
Subject: Re: function ordering (was: Re: [RFC] exit_thread() speedups in x86
 process.c)
In-Reply-To: <20050704092958.GA29325@infradead.org>
Message-ID: <Pine.LNX.4.61.0507041124140.11956@goblin.wat.veritas.com>
References: <200507012258_MC3-1-A340-3A81@compuserve.com>
 <200507021456.40667.vda@ilport.com.ua> <1120391140.3164.39.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.61.0507031323280.6427@goblin.wat.veritas.com>
 <20050704092958.GA29325@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 04 Jul 2005 10:27:08.0661 (UTC) FILETIME=[EE928250:01C58082]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Jul 2005, Christoph Hellwig wrote:
> On Sun, Jul 03, 2005 at 01:30:23PM +0100, Hugh Dickins wrote:
> > > this way we don't need to put a lot of __slow's in the code *and* it's
> > > based on measurements not assumptions, and can be tuned for a specific
> > > situation in addition.
> > 
> > This is reminiscent of "fur", whose source Old SCO opened.
> > Google for SCO fur: amidst all the hits about "fur flying"
> > you might find something useful!
> 
> Was it?  I was at Scaldera back in the days when it was supposed to get
> opensourced, but AFAIK it never actually happened, everyone just talked
> about it.

Look like you're right.  Google shows me an announcement of intent,
and a man page, and an interesting gcc discussion; but no fur source.

Hugh
