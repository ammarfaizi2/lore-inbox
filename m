Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbWDGJCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWDGJCg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 05:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWDGJCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 05:02:36 -0400
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:20436 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932386AbWDGJCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 05:02:36 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] mm: limit lowmem_reserve
Date: Fri, 7 Apr 2006 19:02:15 +1000
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, ck@vds.kolivas.org,
       linux list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
References: <200604021401.13331.kernel@kolivas.org> <200604061110.35789.kernel@kolivas.org> <443605E1.7060203@yahoo.com.au>
In-Reply-To: <443605E1.7060203@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604071902.16011.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 07 April 2006 16:25, Nick Piggin wrote:
> Con Kolivas wrote:
> > It is possible with a low enough lowmem_reserve ratio to make
> > zone_watermark_ok always fail if the lower_zone is small enough.
>
> I don't see how this would happen?

3GB lowmem and a reserve ratio of 180 is enough to do it.

Cheers,
Con
