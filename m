Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261506AbSI1OEq>; Sat, 28 Sep 2002 10:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261518AbSI1OEq>; Sat, 28 Sep 2002 10:04:46 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:35342 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261506AbSI1OEp>; Sat, 28 Sep 2002 10:04:45 -0400
Date: Sat, 28 Sep 2002 15:10:06 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rik van Riel <riel@conectiva.com.br>,
       Tomas Szepe <szepe@pinerecords.com>, Zach Brown <zab@zaboo.net>
Subject: Re: [PATCH][2.5] Single linked headed lists for Linux, v3
Message-ID: <20020928151006.A911@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Thunder from the hill <thunder@lightweight.ods.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Rik van Riel <riel@conectiva.com.br>,
	Tomas Szepe <szepe@pinerecords.com>, Zach Brown <zab@zaboo.net>
References: <20020928144722.A356@infradead.org> <Pine.LNX.4.44.0209280757070.7827-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0209280757070.7827-100000@hawkeye.luckynet.adm>; from thunder@lightweight.ods.org on Sat, Sep 28, 2002 at 08:00:33AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2002 at 08:00:33AM -0600, Thunder from the hill wrote:
> Hi,
> 
> On Sat, 28 Sep 2002, Christoph Hellwig wrote:
> > All of those are utter crap.  Older gcc's had some little inlining
> > problems that generated suboptimal code, but that's cured now and I
> > don't thikn it even made a difference for the small list_* functions.
> 
> I think if we scale slists to be like lists, we don't need to make the 
> difference at all.

twice the size of each entry is a big enough difference.  No need to
add ugly code as second criteria.
