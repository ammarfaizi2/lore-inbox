Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265678AbUF2Kap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265678AbUF2Kap (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 06:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265690AbUF2Kap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 06:30:45 -0400
Received: from mail.dif.dk ([193.138.115.101]:63893 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S265678AbUF2Kam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 06:30:42 -0400
Date: Tue, 29 Jun 2004 12:29:30 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: Peter Lundkvist <p.lundkvist@telia.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm2: random problems with mmap
In-Reply-To: <20040628235031.037627c5.akpm@osdl.org>
Message-ID: <Pine.LNX.4.56.0406291227320.7755@jjulnx.backbone.dif.dk>
References: <20040624014655.5d2a4bfb.akpm@osdl.org> <20040629055906.GA21986@debian>
 <20040628235031.037627c5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2004, Andrew Morton wrote:

> Peter Lundkvist <p.lundkvist@telia.com> wrote:
> >
> > I have problems running cyrus lmtpd; it fails randomly after
> >  fetching 30-50 mails. I have only seen this problem in
> >  2.6.7-mm2 (-mm1 was ok, have not tested -mm3 yet).
>
> The "flexible-mmap" patch was rather broken.  It was dropped for -mm3 and a
> fixed version will be in -mm4.

Ahh, that could perhaps explain why I was getting strange errors from
ldconfig about being unable to mmap certain libraries when I was using
-mm2 (-mm3 works). I'll be sure to watch out for that behaviour with -mm4


--
Jesper Juhl <juhl-lkml@dif.dk>
