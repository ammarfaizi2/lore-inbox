Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268077AbUIGOMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268077AbUIGOMM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 10:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268080AbUIGOMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 10:12:12 -0400
Received: from mail.dif.dk ([193.138.115.101]:63962 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S268077AbUIGOMK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 10:12:10 -0400
Date: Tue, 7 Sep 2004 16:10:12 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Con Kolivas <kernel@kolivas.org>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: attribute warn_unused_result
In-Reply-To: <413DB1DE.6040508@kolivas.org>
Message-ID: <Pine.LNX.4.61.0409071607450.28819@jjulnx.backbone.dif.dk>
References: <413DB1DE.6040508@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Sep 2004, Con Kolivas wrote:

> Date: Tue, 7 Sep 2004 15:04:30 +0200 
> From: Con Kolivas <kernel@kolivas.org>
> To: Con Kolivas <kernel@kolivas.org>
> Cc: Arjan van de Ven <arjanv@redhat.com>,
>     linux kernel mailing list <linux-kernel@vger.kernel.org>,
>     Andrew Morton <akpm@osdl.org>
> Subject: Re: attribute warn_unused_result
> 
> Con Kolivas wrote:
> > Arjan van de Ven wrote:
> >> you really are supposed to use the return value of copy_to_user and 
> >> friends.
> > 
> > 
> > Oh dear I hadn't looked at that. My tree must have been corrupted by 
> > reiser4 doing the in-out thing to me ;P. Excuse the noise.
> Nope a cleanly unpacked bk13 with a minimal config and gcc 3.4.1 
> definitely gives me the following:

Yup, the warnings are there, I see them with bk13 and gcc 3.4.0 as well. 
As I said in my previous mail I'm working on fixing the binfmt_elf bits, 
and unless someone else beats me to it I'll attempt to deal with the rest 
as well.
I'll post the patches as soon as I have something that I feel is resonably 
sane, then you guys can all pick it apart ;)


--
Jesper Juhl <juhl-lkml@dif.dk>
