Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267400AbUJBRen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267400AbUJBRen (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 13:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267446AbUJBRen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 13:34:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26555 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267400AbUJBRee
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 13:34:34 -0400
Date: Sat, 2 Oct 2004 13:06:58 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-mm@kvack.org, akpm@osdl.org, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] memory defragmentation to satisfy high order allocations
Message-ID: <20041002160658.GC7501@logos.cnet>
References: <20041001182221.GA3191@logos.cnet> <415E154A.2040209@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <415E154A.2040209@cyberone.com.au>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 02, 2004 at 12:41:14PM +1000, Nick Piggin wrote:
> 
> 
> Marcelo Tosatti wrote:
> 
> >
> >For example it doesnt re establishes pte's once it has unmapped them.
> >
> >
> 
> Another thing - I don't know if I'd bother re-establishing ptes....
> I'd say just leave it to happen lazily at fault time.

Indeed it should work lazily.


