Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261470AbSIZUEs>; Thu, 26 Sep 2002 16:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261488AbSIZUEI>; Thu, 26 Sep 2002 16:04:08 -0400
Received: from pD9E23892.dip.t-dialin.net ([217.226.56.146]:18409 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S261476AbSIZUEE>; Thu, 26 Sep 2002 16:04:04 -0400
Date: Thu, 26 Sep 2002 14:10:00 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Rik van Riel <riel@conectiva.com.br>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] Single linked lists for Linux, overly complicated
 v2
In-Reply-To: <Pine.LNX.4.44L.0209261659150.1837-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.44.0209261406190.7827-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 26 Sep 2002, Rik van Riel wrote:
> Have you thought about how to _use_ a list without a list head ?

Indeed, that was why I've brought this up at all...

> How are you going to find the list ?

As mentioned: either you keep a primer around, or you have some list entry 
that's getting changed all over while using list_pop(), or you have a 
circular list where you only need to keep one entry around.

			Thunder
-- 
assert(typeof((fool)->next) == typeof(fool));	/* wrong */

