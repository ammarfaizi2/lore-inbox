Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291906AbSBNU6Z>; Thu, 14 Feb 2002 15:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291890AbSBNU4k>; Thu, 14 Feb 2002 15:56:40 -0500
Received: from gatekeeper-WAN.credit.com ([209.155.225.68]:18579 "EHLO
	gatekeeper") by vger.kernel.org with ESMTP id <S291893AbSBNUz4>;
	Thu, 14 Feb 2002 15:55:56 -0500
Date: Thu, 14 Feb 2002 12:54:56 -0800 (PST)
From: Eugene Chupkin <ace@credit.com>
To: Pavel Machek <pavel@suse.cz>
cc: linux-kernel@vger.kernel.org, tmeagher@credit.com
Subject: Re: 2.4.x ram issues?
In-Reply-To: <20020214191356.GB160@elf.ucw.cz>
Message-ID: <Pine.LNX.4.10.10202141253250.683-100000@mail.credit.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 14 Feb 2002, Pavel Machek wrote:

> Hi!
> 
> > I have a problem with high ram support on 2.4.7 to 2.4.17 all behave the
> > same. I have a quad Xeon 700 box with 16gb of ram on an Intel SKA4 board.
> > The ram is all the same 16 1gb PC100 SDRAM modules from Crucial. If I
> > compile the kernel with high ram (64gb) support, my system runs very slow,
> > it takes about 15 minutes for make menuconfig to come up. If I  recompile
> > the kernel with 4gb support, it runs perfectly normal and very fast, but I
> > have 12 gigs that I can't use. Is this a known issue? Is there a fix? I
> > tried just about everything and I am all out of options. Please help!
> 
> What happens with 8GB?
> 									Pavel
> -- 

I didn't test with 8gb since I administrate it remotely, but 16gb is still
having issues with load jumping very high on IO. I think it needs more
work.

-E

