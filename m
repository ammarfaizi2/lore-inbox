Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbVH3TXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbVH3TXl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 15:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbVH3TXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 15:23:41 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:15732 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932398AbVH3TXk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 15:23:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ee2Lplnskz+0cRuO6wN+VxI6T0CeT319tex/S/5f+SDiTt8VilEsyDpDaTvengUz3HnAKKDNMqpoDPTMfN5wkIUDsh5+qbsiLsjt2SuHJfmyla5EOqbytOYs6ploTGIVRls14lPu8l8g/whdSiQn7U6SBg9sR6Aw3VXoh1Lz8q8=
Message-ID: <9a874849050830122329b6546e@mail.gmail.com>
Date: Tue, 30 Aug 2005 21:23:33 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: [PATCH] 2.6.13 - 1/3 - Remove the deprecated function __check_region
Cc: Stephane Wirtel <stephane.wirtel@belgacom.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050830190310.GH10045@granada.merseine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050830170502.GA10694@localhost.localdomain>
	 <9a874849050830101743c421db@mail.gmail.com>
	 <20050830172115.GA11784@localhost.localdomain>
	 <200508301938.00044.jesper.juhl@gmail.com>
	 <20050830175459.GG10045@granada.merseine.nu>
	 <20050830190310.GH10045@granada.merseine.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/05, Muli Ben-Yehuda <mulix@mulix.org> wrote:
> On Tue, Aug 30, 2005 at 08:54:59PM +0300, Muli Ben-Yehuda wrote:
> > On Tue, Aug 30, 2005 at 07:37:59PM +0200, Jesper Juhl wrote:
> > > Here's a quick list of suspects for you :
> >
> > [snip]
> >
> > > ./sound/oss/trident.c
> >
> > I'll take care of this one.
> 
> ... or maybe I won't. We've been using
> request_region()/release_region() since 2001 or so - your grep hit a
> comment to that effect.
> 
Heh, yeah, I guess it probably hit a few. It was just a quick list of
suspects after all.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
