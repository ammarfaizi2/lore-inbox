Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317852AbSIOFl3>; Sun, 15 Sep 2002 01:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317855AbSIOFl3>; Sun, 15 Sep 2002 01:41:29 -0400
Received: from pD952A096.dip.t-dialin.net ([217.82.160.150]:14221 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317852AbSIOFl2>; Sun, 15 Sep 2002 01:41:28 -0400
Date: Sat, 14 Sep 2002 23:46:20 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: mdew <mdew@mdew.dyndns.org>
cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] [PATCH] Linux-2.5.34-mcp4
In-Reply-To: <1032051401.10627.35.camel@mdew>
Message-ID: <Pine.LNX.4.44.0209142345390.10048-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15 Sep 2002, mdew wrote:
> xfs_dmapi.c:207: `list_t' undeclared (first use in this function)

Change this to `struct list_head', since we've kicked out list_t.

			Thunder
-- 
!assert(typeof((fool)->next) == (fool));

