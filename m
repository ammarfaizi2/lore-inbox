Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262776AbSI1Jja>; Sat, 28 Sep 2002 05:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262775AbSI1Jja>; Sat, 28 Sep 2002 05:39:30 -0400
Received: from pD9E23260.dip.t-dialin.net ([217.226.50.96]:64134 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S262776AbSI1Jj3>; Sat, 28 Sep 2002 05:39:29 -0400
Date: Sat, 28 Sep 2002 03:45:33 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Zach Brown <zab@zabbo.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] Single linked lists for Linux, overly complicated
 v2
In-Reply-To: <20020926205727.T13817@bitchcake.off.net>
Message-ID: <Pine.LNX.4.44.0209280343330.7827-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 26 Sep 2002, Zach Brown wrote:
> #define TSLIST_MEMBER_INIT(member) 		\
> 	NULL

My problem with this is that you could initialize anything with it, 
without even getting the notice. That's why I've preferred the named 
initializer version. I could even do

#define SLIST_HEAD_INIT(name)			\
	.next = NULL;

if you like that better, and yes, I guess it should be...

			Thunder
-- 
assert(typeof((fool)->next) == typeof(fool));	/* wrong */

