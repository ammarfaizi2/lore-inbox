Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314843AbSD2HXI>; Mon, 29 Apr 2002 03:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314848AbSD2HXH>; Mon, 29 Apr 2002 03:23:07 -0400
Received: from loewe.cosy.sbg.ac.at ([141.201.2.12]:58252 "EHLO
	loewe.cosy.sbg.ac.at") by vger.kernel.org with ESMTP
	id <S314843AbSD2HXG>; Mon, 29 Apr 2002 03:23:06 -0400
Date: Mon, 29 Apr 2002 09:23:05 +0200 (MET DST)
From: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
To: Rolf Fokkens <fokkensr@linux06.vertis.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module locking
In-Reply-To: <200204290711.g3T7Bm217822@linux06.vertis.nl>
Message-ID: <Pine.GSO.4.05.10204290922080.21672-100000@mausmaki.cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

... oops, sorry

> -	if (!capable(CAP_SYS_MODULE))
> +	if (module_lock || !capable(CAP_SYS_MODULE))

the capable call is sthell there, but with the module_lock
kind or redundant.

	tm

-- 
in some way i do, and in some way i don't.

