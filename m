Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbULYVCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbULYVCZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 16:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbULYVCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 16:02:25 -0500
Received: from mail.dif.dk ([193.138.115.101]:14027 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261563AbULYVCW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 16:02:22 -0500
Message-ID: <41CDD7EA.5010406@dif.dk>
Date: Sat, 25 Dec 2004 22:13:14 +0100
From: Jesper Juhl <juhl-lkml@dif.dk>
Organization: DIF
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeremy Huddleston <eradicator@gentoo.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][1/2] - catch ignored copy_*_user() - fs/binfmt_elf.c
References: <1103976179.1006.31.camel@cid.outersquare.org>
In-Reply-To: <1103976179.1006.31.camel@cid.outersquare.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Huddleston wrote:
> Here are a couple patches to cleanup some uncaught copy_*_user() calls.
> 
> 
> 
> Catch and handle some previously ignored copy_*_user() calls
> 
This is more or less identical to the patch I've posted a few times 
(last time under the subject '[PATCH] binfmt_elf; do proper error 
handling if clear_user fails in padzero') and it looks sane to me.
Last time I heard anything about this Andrew said he had that patch (and 
a few related) on his todo list.

Anyway, I'll sign off on this one.

> Signed-off-by: Jeremy Huddleston <eradicator@gentoo.org>
> 
Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>


