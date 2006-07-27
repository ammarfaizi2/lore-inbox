Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWG0DbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWG0DbR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 23:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWG0DbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 23:31:17 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:43748 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1751117AbWG0DbQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 23:31:16 -0400
Message-ID: <1153971041.44c833619915b@portal.student.luth.se>
Date: Thu, 27 Jul 2006 05:30:41 +0200
From: ricknu-0@student.ltu.se
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, jeff@garzik.org,
       adobriyan@gmail.com, vlobanov@speakeasy.net, jengelh@linux01.gwdg.de,
       getshorty_@hotmail.com, pwil3058@bigpond.net.au, mb@bu3sch.de,
       penberg@cs.helsinki.fi, stefanr@s5r6.in-berlin.de, larsbj@gullik.net
Subject: Re: [RFC][PATCH] A generic boolean (version 6)
References: <1153341500.44be983ca1407@portal.student.luth.se> <1153945705.44c7d069c5e18@portal.student.luth.se> <20060726180622.63be9e55.pj@sgi.com>
In-Reply-To: <20060726180622.63be9e55.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 130.240.42.170
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Citerar Paul Jackson <pj@sgi.com>:

> Fun stuff to do in the future:
>   Convert test_bit() and various other test_*() and
> 	atomic_*() operators to return bool.
>   Convert many TRUE/FALSE to true/false, in a patch of
> 	similar size to Andrew's March 2006 patch entitled:
> 	"[patch 1/1] consolidate TRUE and FALSE".
>   Convert a variety of spellings of BOOLEAN to "bool".
>   Convert routines and variables using the old C
> 	convention of int/0/1 for boolean to the
> 	new bool/false/true.
>   How do we detect breakage that results from converting
> 	an apparent boolean to these values, when the
> 	code actually worked by using more than just
> 	values 0 and 1 for the variable in question?
>   How do we detect any breakage caused by possible changes
> 	in the sizeof variables whose type we changed?
>   Various sparse and/or gcc checks that benefit from
> 	knowing the additional constraints on bool types.

Well... that's some work to be done :)

Will save the list and try to mark it of along the road.

>                   Paul Jackson <pj@sgi.com> 1.925.600.0401

/Richard Knutsson
