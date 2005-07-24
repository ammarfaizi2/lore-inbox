Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVGXUOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVGXUOO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 16:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVGXUOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 16:14:14 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:38328 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261228AbVGXUOM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 16:14:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nXZsxkQHXfX687tVwPRJlb5HYa4Rkwm0WmZ+9YoFOwQnScIRXZSdviT6TId/4qHIELRcaNoo/3kRvr7xO1waCgeBhzIuhJxGgprtCSCF6rxO2jAd2cFQpHQT+SxVBxBP82n5hvPIKqFeapw3gJA9DeFekSFkfIDNEIsfzilEkr4=
Message-ID: <9a874849050724131418fb3e66@mail.gmail.com>
Date: Sun, 24 Jul 2005 22:14:12 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: lkml@dodo.com.au
Subject: Re: 2.6.13-rc3 test: finding compile errors with make randconfig
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
In-Reply-To: <glq7e1ttejp2sh7uuo6nil2vafljdprkpk@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <f8b6e1h2t4tlto7ia8gs8aanpib68mhit6@4ax.com>
	 <20050724091327.GQ3160@stusta.de>
	 <glq7e1ttejp2sh7uuo6nil2vafljdprkpk@4ax.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/05, Grant Coady <lkml@dodo.com.au> wrote:
> On Sun, 24 Jul 2005 11:13:27 +0200, Adrian Bunk <bunk@stusta.de> wrote:
> 
> With > 2k (raw) errors in 97.something builds of 2.6.12.3, why go
> looking for trouble in -mm?

Because -mm is the development tree. The things in -mm are what's
eventually going to end up in mainline, so that's what you want to be
testing and fixing, and it's also further ahead than 2.6.12.3 (which
is esentially a dead branch except for critical fixes) so stuff may
already have been fixed there that was broken in 2.6.12.3

> >
> >And doing the compilations is really the trivial part of the work, the
> Got to start somewhere :)
> 
Right you are, and I for one am glad you do it. I build randconfig
kernels myself to look for trouble spots, but I can't get anywhere
near building 200+ configs. On a good day I may build 5 or 6
randconfigs of the latest kernel inbetween doing other things, so
getting hold of the results of several hundred randconfig builds gives
me a lot of material to work on that I would never have the time to
gather myself. Thanks.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
