Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263077AbTE0Dde (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 23:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263084AbTE0Dde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 23:33:34 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:27824 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S263077AbTE0Ddd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 23:33:33 -0400
Date: Tue, 27 May 2003 00:44:46 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IDE config correctness (was: Linux 2.4.21-rc4)
In-Reply-To: <3ED2C16D.6090904@gmx.net>
Message-ID: <Pine.LNX.4.55L.0305270043150.32094@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0305261734320.21581@freak.distro.conectiva>
 <3ED2C16D.6090904@gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It seems Alan still has some very important fixes pending. If so, I'll
release -rc5 tomorrow with your stuff.

Otherwise it will have to wait for .22-pre.

On Tue, 27 May 2003, Carl-Daniel Hailfinger wrote:

> Marcelo Tosatti wrote:
> > Hi,
> >
> > Here goes -rc4, hopefully fixing all problems now.
> >
> > rc5 will only be released in case of REALLY bad problems.
>
> Not really a bad problem, but CONFIG_PDC202XX_BURST should be selectable
> even if CONFIG_BLK_DEV_PDC202XX_OLD=m
> You decide if this goes into 2.4.21. I do not feel strongly about it.
>
> >   o Cset exclude: c-d.hailfinger.kernel.2003@gmx.net|ChangeSet|20030526190224|33683
> >   o Really fix xconfig breakage
>
> My fix for the xconfig breakage also included this IDE config fix. When
> you excluded the cset, it got lost.
>
> Attached is the diff on top of your tree.
>
>
> Regards,
> Carl-Daniel
>
