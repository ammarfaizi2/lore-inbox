Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317035AbSF1DCI>; Thu, 27 Jun 2002 23:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317040AbSF1DCH>; Thu, 27 Jun 2002 23:02:07 -0400
Received: from ns.suse.de ([213.95.15.193]:6415 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317035AbSF1DCG>;
	Thu, 27 Jun 2002 23:02:06 -0400
To: Bendi Vinaya Kumar <vbendi@cs.clemson.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Skbuff Trimming
References: <Pine.GSO.4.44.0206271756540.727-100000@noisy.cs.clemson.edu.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 28 Jun 2002 05:04:26 +0200
In-Reply-To: Bendi Vinaya Kumar's message of "28 Jun 2002 00:16:41 +0200"
Message-ID: <p73k7okm7d1.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bendi Vinaya Kumar <vbendi@cs.clemson.edu> writes:

> But, it does not do the same on
> "frag_list". Why?

frag_list is not a general purpose skbuff facility and is not used by
most protocols and not directly supported by most of skbuff.c It is just 
supported by some specific paths to enable lazy defragmenting. It is not
an attempt to turn skbuffs into mbufs.

-Andi

