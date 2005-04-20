Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbVDTUUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbVDTUUg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 16:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbVDTUUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 16:20:36 -0400
Received: from mail.dif.dk ([193.138.115.101]:57272 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261799AbVDTUUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 16:20:30 -0400
Date: Wed, 20 Apr 2005 22:23:34 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rename rw_verify_area() to rw_access_ok()
In-Reply-To: <20050420150126.GA7731@logos.cnet>
Message-ID: <Pine.LNX.4.62.0504202217140.2071@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0504172346120.2586@dragon.hyggekrogen.localhost>
 <20050420150126.GA7731@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2005, Marcelo Tosatti wrote:

> On Sun, Apr 17, 2005 at 11:50:35PM +0200, Jesper Juhl wrote:
> > verify_area() will soon be dead and gone, replaced by access_ok(), thus 
> > the function named rw_verify_area() is badly named and should be renamed. 
> > This patch renames rw_verify_area to rw_access_ok which seems more 
> > appropriate (it also updates all callers of the functions as well as 
> > references to it in comments).
> 
> Not that I care too much, but, rw_verify_area() has nothing to do with 
> verify_area/access_ok functions.
> 
right, access_ok deals with memory, rw_verify_area deals with files, but 
both serve a similar purpose - validating access to a region. That's why I 
thought it would make sense to have them named similarly (as they used to 
be). 

> I dont see real need to rename this function. 
> 
Perhaps I went a tad too far, or perhaps I misunderstood the point of 
rw_verify_area(), that's certainly a possibility. In any case, it's no big 
deal, I just thought it was the logical thing to do - I'll leave it in 
Andrews capable hands to decide.

Thank you for commenting.


-- 
Jesper Juhl


