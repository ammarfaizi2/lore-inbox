Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261637AbVADOCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbVADOCM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 09:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbVADOCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 09:02:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:16614 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261637AbVADOCK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 09:02:10 -0500
Date: Tue, 4 Jan 2005 09:01:47 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Manfred Spraul <manfred@colorfullife.com>
cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] periodically scan redzone entries and slab control
 structures
In-Reply-To: <Pine.LNX.4.44.0501032223360.1865-100000@dbl.q-ag.de>
Message-ID: <Pine.LNX.4.61.0501040900200.25392@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.44.0501032223360.1865-100000@dbl.q-ag.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jan 2005, Manfred Spraul wrote:

> The attached patch adds a periodic scan over all objects and checks for
> wrong redzone data or corrupted bufctl lists.

Awesome.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
