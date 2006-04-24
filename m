Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751337AbWDXWaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWDXWaP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 18:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWDXWaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 18:30:14 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:9995 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751337AbWDXWaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 18:30:13 -0400
Date: Tue, 25 Apr 2006 00:30:03 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Martin Mares <mj@ucw.cz>
Cc: marty fouts <mf.danger@gmail.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ modules
Message-ID: <20060424223003.GB13027@w.ods.org>
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com> <1145911546.1635.54.camel@localhost.localdomain> <444D3D32.1010104@argo.co.il> <A6E165E4-8D43-4CF8-B48C-D4B0B28498FB@mac.com> <9f7850090604241450w885fa98v36657ba5f12f071c@mail.gmail.com> <mj+md-20060424.220809.6996.atrey@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mj+md-20060424.220809.6996.atrey@ucw.cz>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2006 at 12:09:01AM +0200, Martin Mares wrote:
> Hello!
> 
> > Oh, and yeah, a = b + c *is* more readable than
> > 
> > a = malloc(strlen(b) + strlen(c));
> > strcpy(a,b);
> > strcat(a,c);
> > 
> > and contains fewer bugs ;)
> 
> Actually, it contains at least the bug you have made in your C example,
> that is forgetting that malloc() can fail. So can string addition, if
> allocated dynamically.

And if it does not fail, it may overflow because he forgot one char in
the malloc(). Anyway, I still prefer the C form, at least I know what
it does.

Cheers,
Willy

