Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261566AbSI1ONb>; Sat, 28 Sep 2002 10:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261570AbSI1ONb>; Sat, 28 Sep 2002 10:13:31 -0400
Received: from pD9E23260.dip.t-dialin.net ([217.226.50.96]:49288 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S261566AbSI1ONb>; Sat, 28 Sep 2002 10:13:31 -0400
Date: Sat, 28 Sep 2002 08:19:24 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Christoph Hellwig <hch@infradead.org>
cc: Thunder from the hill <thunder@lightweight.ods.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rik van Riel <riel@conectiva.com.br>,
       Tomas Szepe <szepe@pinerecords.com>, Zach Brown <zab@zaboo.net>
Subject: Re: [PATCH][2.5] Single linked headed lists for Linux, v3
In-Reply-To: <20020928151006.A911@infradead.org>
Message-ID: <Pine.LNX.4.44.0209280817450.7827-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 28 Sep 2002, Christoph Hellwig wrote:
> twice the size of each entry is a big enough difference.  No need to
> add ugly code as second criteria.

We just have to add one little ugliness in order to generate even more 
useful code. As to that, I do definitely disagree with inlining these 
functions. (There are really lots of functions where inlining actually 
makes an awful lot of sense, but this one isn't amongst them.)

			Thunder

