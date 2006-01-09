Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbWAIUl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWAIUl1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 15:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWAIUl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 15:41:27 -0500
Received: from gold.veritas.com ([143.127.12.110]:29107 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751323AbWAIUl0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 15:41:26 -0500
Date: Mon, 9 Jan 2006 20:41:37 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Doug Gilbert <dougg@torque.net>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Mike Christie <michaelc@cs.wisc.edu>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm
In-Reply-To: <9a8748490601091230g5ed68e07rc379e52ef06ec31a@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0601092039010.16368@goblin.wat.veritas.com>
References: <20060107052221.61d0b600.akpm@osdl.org> 
 <9a8748490601070708p4353eb0ev9ea15edee132b13b@mail.gmail.com> 
 <9a8748490601090947i524d5f73uf5ccd06d8c693cae@mail.gmail.com> 
 <20060109175748.GD25102@redhat.com>  <9a8748490601091001y74fba5q2cd7e08a324701c3@mail.gmail.com>
  <Pine.LNX.4.61.0601091819160.14800@goblin.wat.veritas.com> 
 <9a8748490601091048x46716e25u2fe2ebe9b5fbc9bb@mail.gmail.com> 
 <Pine.LNX.4.61.0601091857430.15219@goblin.wat.veritas.com> 
 <9a8748490601091139pf5fb6a0v3c8b3bcb41b85940@mail.gmail.com> 
 <Pine.LNX.4.61.0601092005510.16057@goblin.wat.veritas.com>
 <9a8748490601091230g5ed68e07rc379e52ef06ec31a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 09 Jan 2006 20:41:26.0278 (UTC) FILETIME=[0F7F4A60:01C6155D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2006, Jesper Juhl wrote:
> On 1/9/06, Hugh Dickins <hugh@veritas.com> wrote:
> >
> > sg_page_malloc clear the data buffer, not that extent of mem_map.
> 
> Hugh, you're a genious!
> I added your small patch on top of your previous one and now
> 2.6.15-mm2 doesn't crash any more  :-)

Great, thanks a lot for trying it.  I'll rush that one to Linus now
(the __GFP_COMP patch can wait and go through the proper channels).

Hugh
