Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263158AbUCYOpG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 09:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263169AbUCYOpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 09:45:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:61413 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263158AbUCYOpB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 09:45:01 -0500
Date: Thu, 25 Mar 2004 09:44:41 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Pavel Machek <pavel@ucw.cz>
cc: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH] RSS limit enforcement for 2.6
In-Reply-To: <20040318220432.GB1505@openzaurus.ucw.cz>
Message-ID: <Pine.LNX.4.44.0403250944250.11915-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2004, Pavel Machek wrote:

> When running lingvistics computation, machine got completely
> unusable due to bad memory pressure. nice -n 19 was
> useless. Memory limit should help.

Is this with the new patch, with the old patch or
without any RSS limiting patch ?

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

