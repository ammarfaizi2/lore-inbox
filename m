Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261607AbSI0Ou2>; Fri, 27 Sep 2002 10:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261714AbSI0Ou2>; Fri, 27 Sep 2002 10:50:28 -0400
Received: from pD9E239ED.dip.t-dialin.net ([217.226.57.237]:56704 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S261607AbSI0Ou2>; Fri, 27 Sep 2002 10:50:28 -0400
Date: Fri, 27 Sep 2002 08:56:17 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Peter Chubb <peter@chubb.wattle.id.au>
cc: Rik van Riel <riel@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] Single linked lists for Linux, overly complicated
 v2
In-Reply-To: <15763.55020.35426.721691@wombat.chubb.wattle.id.au>
Message-ID: <Pine.LNX.4.44.0209270855000.7827-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 27 Sep 2002, Peter Chubb wrote:
> What is the problem these lists are intended to solve?

Reduction of effort in the place where we only have single-direction 
lists, such as stacks and the scheduler. (That is, whereever we don't need 
to step back.)

> There's no point in adding general infrastructure that has no immediate
> uses -- it just ends up mouldering in a corner, (like the generic
> hashing code linux/ghash.h which has been in the kernel for 4 or 5
> years, and still has *no* uses.)

Wasn't it already removed?

			Thunder
-- 
assert(typeof((fool)->next) == typeof(fool));	/* wrong */

