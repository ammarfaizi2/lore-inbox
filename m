Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262166AbULLWyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262166AbULLWyb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 17:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbULLWy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 17:54:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56029 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262162AbULLWyU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 17:54:20 -0500
Date: Sun, 12 Dec 2004 17:53:09 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Adrian Bunk <bunk@stusta.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mm/thrash.c: make a variable static
In-Reply-To: <20041212200339.GR22324@stusta.de>
Message-ID: <Pine.LNX.4.61.0412121752440.27482@chimarrao.boston.redhat.com>
References: <20041212200339.GR22324@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Dec 2004, Adrian Bunk wrote:

> --- linux-2.6.10-rc2-mm4-full/mm/thrash.c.old	2004-12-12 04:00:18.000000000 +0100
> +++ linux-2.6.10-rc2-mm4-full/mm/thrash.c	2004-12-12 04:00:25.000000000 +0100

> -unsigned long swap_token_check;
> +static unsigned long swap_token_check;

Looks good to me.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
