Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275973AbTHOMzV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 08:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275975AbTHOMzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 08:55:21 -0400
Received: from 69-55-72-141.ppp.netsville.net ([69.55.72.141]:32641 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S275973AbTHOMzJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 08:55:09 -0400
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
From: Chris Mason <mason@suse.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: marcelo@conectiva.com.br, green@namesys.com, akpm@osdl.org, andrea@suse.de,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20030815122827.067bd429.skraw@ithnet.com>
References: <20030814084518.GA5454@namesys.com>
	 <Pine.LNX.4.44.0308141425460.3360-100000@localhost.localdomain>
	 <20030814194226.2346dc14.skraw@ithnet.com>
	 <1060913337.1493.29.camel@tiny.suse.com>
	 <20030815122827.067bd429.skraw@ithnet.com>
Content-Type: text/plain
Message-Id: <1060952100.5046.2.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 15 Aug 2003 08:55:00 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-15 at 06:28, Stephan von Krawczynski wrote:
> On 14 Aug 2003 22:08:58 -0400
> Chris Mason <mason@suse.com> wrote:
> 
> > Run 4 or so fsx-linux programs (each to its own file) and use usemem to
> > put your box into swap.  That should hit it pretty quickly, and any
> > errors from fsx indicate problems.
> 
> Question: how do I make fsx-linux use big filesizes (GB range) ?

You don't really need to, fsx-linux is pretty good at triggering
problems with its default file size.  Usually you just need some other
load in place to chew up ram.

-chris


