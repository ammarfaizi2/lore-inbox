Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314841AbSD2HVk>; Mon, 29 Apr 2002 03:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314842AbSD2HVj>; Mon, 29 Apr 2002 03:21:39 -0400
Received: from loewe.cosy.sbg.ac.at ([141.201.2.12]:43916 "EHLO
	loewe.cosy.sbg.ac.at") by vger.kernel.org with ESMTP
	id <S314841AbSD2HVi>; Mon, 29 Apr 2002 03:21:38 -0400
Date: Mon, 29 Apr 2002 09:21:36 +0200 (MET DST)
From: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
To: Rolf Fokkens <fokkensr@linux06.vertis.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module locking
In-Reply-To: <200204290711.g3T7Bm217822@linux06.vertis.nl>
Message-ID: <Pine.GSO.4.05.10204290919360.21672-100000@mausmaki.cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Apr 2002, Rolf Fokkens wrote:

> This patch adds the option op locking module operations, which
> means that no more insmod en rmmod operations are possible. This
> hopefully satisfies some security requirements that state that no
> modularized kernels should be used to be really safe in some
> environents.

you're describing exactly the bahaviour or using capabilities.
see the capable(CAP_SYS_MODULE) calls you removed with your patch.

	tm

-- 
in some way i do, and in some way i don't.

