Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281739AbRLQSE4>; Mon, 17 Dec 2001 13:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281762AbRLQSEr>; Mon, 17 Dec 2001 13:04:47 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:64013 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S281739AbRLQSEl>; Mon, 17 Dec 2001 13:04:41 -0500
Date: Mon, 17 Dec 2001 14:49:44 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Yoshiki Hayashi <yoshiki@xemacs.org>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.16 Fix NULL pointer dereferencing in agpgart_be.c
In-Reply-To: <20011217140036.4a0e8969.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.21.0112171449020.3255-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Dec 2001, Stephan von Krawczynski wrote:

> > The attached patch add NULL check before dereferencing the
> > pointer to fix the problem.
> 
> This was solved some weeks ago and the patch is pending somewhere (marcelo?).

The whole patch is queued for 2.4.18pre..

> Unfortunately the complete cure is inside this pending patch, because there are
> other small tweaks for i830M. The NULL-check is sufficient for non-oops, but
> i830-register size is smaller than the further ongoings inside agpgart_be.c.

