Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbUCBWKk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 17:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbUCBWKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 17:10:40 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:38345 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S261923AbUCBWKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 17:10:31 -0500
From: Darren Williams <dsw@gelato.unsw.edu.au>
To: albhaf <albhaf@home.se>
Date: Wed, 3 Mar 2004 09:10:25 +1100
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Better performance with 2.6
Message-ID: <20040302221025.GA18011@cse.unsw.EDU.AU>
References: <1078229894.53b994c0albhaf@home.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078229894.53b994c0albhaf@home.se>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi albhaf

Look at the slab allocator, this is a cache
for commonly used objects in the kernel.

For more info see the original document:
The Slab Allocator:
An object caching kernel memory allocator
Jeff Bonwick

and

mm/slab.c

A quick google should turn up the correct paper.

Darren

On Tue, 02 Mar 2004, albhaf wrote:

> I know that 2.6 has the ability to get better
> performance than the other versions.
> But what parts of the kernel has provided to this
> performance upgrade?
> 
> /albhaf
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--------------------------------------------------
Darren Williams <dsw AT gelato.unsw.edu.au>
Gelato@UNSW <www.gelato.unsw.edu.au>
--------------------------------------------------
