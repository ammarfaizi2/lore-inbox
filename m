Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWBBLQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWBBLQm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 06:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbWBBLQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 06:16:42 -0500
Received: from uproxy.gmail.com ([66.249.92.199]:61076 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750767AbWBBLQl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 06:16:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ak15Jjcm+BZc5LiAyJS23BEw6mb7xK9kow0MQ16T/B74GAM6hQBbAbgYWd7K6W61vSCTLgHexHGM+AXGqjfomCYOXCAN6RqhAexqmhYj3UfOheHYLj9c/gKKLUpBau7F4GfZGz78FQKrnxDWV7cqChKesoBLRgEXdEJeK4ABUx8=
Message-ID: <84144f020602020316x1a996f74u8099df2696c716b4@mail.gmail.com>
Date: Thu, 2 Feb 2006 13:16:40 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [ 01/10] [Suspend2] kernel/power/modules.h
Cc: Nigel Cunningham <nigel@suspend2.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20060202110235.GE1884@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
	 <200602012245.06328.nigel@suspend2.net>
	 <84144f020602010501k23e7898at82c0f231a2da0ad4@mail.gmail.com>
	 <200602020730.16916.nigel@suspend2.net>
	 <84144f020602011345i2e395336s371786c441b9f5b2@mail.gmail.com>
	 <20060202100646.GC1981@elf.ucw.cz>
	 <84144f020602020257g72bda32bkc3d6264495bea2aa@mail.gmail.com>
	 <20060202110235.GE1884@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On St 01-02-06 23:45:15, Pekka Enberg wrote:
> > So what's the plan for short-term? Are userspace suspend and suspend
> > modules mutually exclusive or can they co-exist?

On 2/2/06, Pavel Machek <pavel@ucw.cz> wrote:
> They can coexist for as long as neccessary. (At one point, it was even
> possible to suspend using userland code, then resume using kernel code
> :-).
>
> When I found out noone is really using kernel code any more (2.8.0 or
> something), I'd like to get rid of it.

So are you saying we should pursue merging Suspend2 bits in the
mainline and deprecate it when userspace is mature enough and has all
the same features? Seems counter-productive but then again I am mostly
clueless of suspend issues.

                                        Pekka
