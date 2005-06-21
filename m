Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261795AbVFUTh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbVFUTh5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 15:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262255AbVFUTh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 15:37:57 -0400
Received: from silver.veritas.com ([143.127.12.111]:51886 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S261795AbVFUThw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 15:37:52 -0400
Date: Tue, 21 Jun 2005 20:38:51 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Timur Tabi <timur.tabi@ammasso.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: get_user_pages() and shared memory question
In-Reply-To: <42B85AB4.7030401@ammasso.com>
Message-ID: <Pine.LNX.4.61.0506212037080.7385@goblin.wat.veritas.com>
References: <42B82DF2.2050708@ammasso.com> <Pine.LNX.4.61.0506211840210.5784@goblin.wat.veritas.com>
 <42B85AB4.7030401@ammasso.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 21 Jun 2005 19:37:51.0313 (UTC) FILETIME=[B6285410:01C57698]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2005, Timur Tabi wrote:
> 
> In this case, when a process creates a new memory segment, I just want to know
> whether the pages with a non-zero refcount (because of the get_user_pages()
> call) can ever be used in a new shared memory segment.
> 
> I'm assuming the answer is no, because that would defeat the purpose of
> refcount (right?).

Exactly right.

Hugh
