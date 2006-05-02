Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbWEBF1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbWEBF1F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 01:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbWEBF1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 01:27:05 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:52822 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932373AbWEBF1E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 01:27:04 -0400
Date: Tue, 2 May 2006 07:27:09 +0200
From: Jens Axboe <axboe@suse.de>
To: Bob Copeland <me@bobcopeland.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
       "Petri T. Koistinen" <petri.koistinen@iki.fi>,
       Andrew Morton <akpm@osdl.org>, trivial@kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/bio.c: initialize variable, remove warning
Message-ID: <20060502052708.GO3814@suse.de>
References: <Pine.LNX.4.64.0605012353100.5245@joo> <20060501210546.GB7170@mipter.zuzino.mipt.ru> <b6c5339f0605011419w7770a634t60bce8ce693a3749@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6c5339f0605011419w7770a634t60bce8ce693a3749@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01 2006, Bob Copeland wrote:
> On 5/1/06, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >On Mon, May 01, 2006 at 11:55:27PM +0300, Petri T. Koistinen wrote:
> >> Remove compiler warning by initializing uninitialized variable.
> >
> >oh no not again!
> 
> What about:
> 
> >> -                     unsigned long idx;
> +                     unsigned long idx;   /* please don't patch bogus
> warning */

I'll take that patch if you send it :-)

-- 
Jens Axboe

