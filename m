Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbVDDV5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVDDV5X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 17:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbVDDVyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 17:54:40 -0400
Received: from host201.dif.dk ([193.138.115.201]:60421 "EHLO
	diftmgw2.backbone.dif.dk") by vger.kernel.org with ESMTP
	id S261431AbVDDVxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 17:53:10 -0400
Date: Mon, 4 Apr 2005 23:55:30 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] no need to cast pointer to (void *) when passing it to
 kfree()
In-Reply-To: <Pine.LNX.4.62.0504042326220.2496@dragon.hyggekrogen.localhost>
Message-ID: <Pine.LNX.4.62.0504042353470.2496@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0504042326220.2496@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Apr 2005, Jesper Juhl wrote:

> 
> kfree() takes a void pointer argument, no need to cast.
> 
I'm an idiot, vm_start is an unsigned long, of course it needs to be 
cast.. D'OH!   Don't apply that patch... Don't know what I was thinking.


-- 
Jesper


