Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVDEKkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVDEKkQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 06:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVDEKkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 06:40:16 -0400
Received: from host201.dif.dk ([193.138.115.201]:11530 "EHLO
	diftmgw2.backbone.dif.dk") by vger.kernel.org with ESMTP
	id S261208AbVDEKkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 06:40:11 -0400
Date: Tue, 5 Apr 2005 12:39:44 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: David Howells <dhowells@redhat.com>
cc: Jesper Juhl <juhl-lkml@dif.dk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] no need to cast pointer to (void *) when passing it to
 kfree() 
In-Reply-To: <26741.1112695498@redhat.com>
Message-ID: <Pine.LNX.4.62.0504051238410.15967@jjulnx.backbone.dif.dk>
References: <Pine.LNX.4.62.0504042326220.2496@dragon.hyggekrogen.localhost>
  <26741.1112695498@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Apr 2005, David Howells wrote:

> Date: Tue, 05 Apr 2005 11:04:58 +0100
> From: David Howells <dhowells@redhat.com>
> To: Jesper Juhl <juhl-lkml@dif.dk>
> Cc: linux-kernel <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH] no need to cast pointer to (void *) when passing it to
>     kfree() 
> 
> Jesper Juhl <juhl-lkml@dif.dk> wrote:
> 
> > kfree() takes a void pointer argument, no need to cast.
> 
> vma->vm_start is unsigned long (unless it's changed since last I looked):
> 
As I wrote in the reply I send to my original mail I made a stupid 
mistake. Don't know what I was thinking. Sorry.

-- 
Jesper


