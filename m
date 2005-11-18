Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161138AbVKRTo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161138AbVKRTo6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 14:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161140AbVKRTol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 14:44:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24978 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161138AbVKRToj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 14:44:39 -0500
Date: Fri, 18 Nov 2005 11:44:30 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Josh Boyer <jwboyer@gmail.com>
cc: Greg Kroah-Hartman <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, scjody@steamballoon.com
Subject: Re: [patch 1/3] Add SCM info to MAINTAINERS
In-Reply-To: <625fc13d0511181134lc074b8avcc8db47b8723583@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0511181142140.13959@g5.osdl.org>
References: <20051118173930.270902000@press.kroah.org>  <20051118173054.GA20860@kroah.com>
 <20051118173106.GB20860@kroah.com> <625fc13d0511181134lc074b8avcc8db47b8723583@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 18 Nov 2005, Josh Boyer wrote:
> 
> MTD also has a CVS tree... which begs the question as to whether or
> not CVS trees can be added to the SCM type?

I'd argue against it.

CVS is a piece of crap, and anyody who maintaines stuff in CVS just makes 
it harder to ever merge back. That's not just a theory - we've had that 
situation happen in real life over the years, which is why I definitely 
don't want to see any external CVS trees given any kind of recognition at 
all.

			Linus
