Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267685AbTGHVTm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 17:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267686AbTGHVTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 17:19:42 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:43965 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S267685AbTGHVTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 17:19:41 -0400
Date: Tue, 8 Jul 2003 18:31:16 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Lukasz Trabinski <lukasz@wsisiz.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops on 2.4.22-pre2
In-Reply-To: <Pine.LNX.4.53.0307021529310.19377@oceanic.wsisiz.edu.pl>
Message-ID: <Pine.LNX.4.55L.0307081828020.25622@freak.distro.conectiva>
References: <Pine.LNX.4.53.0307021529310.19377@oceanic.wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Lukasz,

We have discussed the problem and there is a partial fix in the current
2.4 BK tree. ChangeSet@1.1070 is the fix.

Can you try to reproduce the problem with the latest BK tree?

On Wed, 2 Jul 2003, Lukasz Trabinski wrote:

> Hello
>
> Here is oops on 2.4.22-pre2 :(

> >>EIP; f8a403ff <[jbd]journal_start+5f/c0>   <=====
>
> >>ebx; e20f8f00 <_end+21d67bfc/386aed5c>
> >>edx; d8249f7c <_end+17eb8c78/386aed5c>
> >>esi; c72ba000 <_end+6f28cfc/386aed5c>
> >>edi; f2678600 <_end+322e72fc/386aed5c>
> >>esp; c72bbb38 <_end+6f2a834/386aed5c>

