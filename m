Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275226AbTHMO7p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 10:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275229AbTHMO7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 10:59:45 -0400
Received: from angband.namesys.com ([212.16.7.85]:16786 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S275226AbTHMO7m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 10:59:42 -0400
Date: Wed, 13 Aug 2003 18:59:40 +0400
From: Oleg Drokin <green@namesys.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Stephan von Krawczynski <skraw@ithnet.com>, akpm@osdl.org, andrea@suse.de,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, mason@suse.com
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
Message-ID: <20030813145940.GC26998@namesys.com>
References: <20030813125509.360c58fb.skraw@ithnet.com> <Pine.LNX.4.44.0308131143570.4279-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308131143570.4279-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Aug 13, 2003 at 11:53:09AM -0300, Marcelo Tosatti wrote:

> > Running SMP. So far no crash happened under ext3. 
> > Still I see the tar-verification errors. None on the first day, 2 on the second

But tar verification errors are still bad, right?

> > it still crashes, then ideas for patches will be welcome :-)
> Great you tracked it down. Your previous traces almost always involved
> reiserfs calls, which is another indicator that reiserfs is probably the
> problem here.

reiserfs is just probably a bit more sensitive to memory corruptions.

> Chris, Oleg, it might be nice if you guys could look at previous oops
> reports by Stephan. 

All of them looked like memory corruptions of unknown reason to me.

Bye,
    Oleg
