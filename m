Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbWFULSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWFULSL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 07:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWFULSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 07:18:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21997 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932073AbWFULSK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 07:18:10 -0400
Date: Wed, 21 Jun 2006 04:17:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm1
Message-Id: <20060621041758.4235dbc6.akpm@osdl.org>
In-Reply-To: <6bffcb0e0606210407y781b3d41nef533847f579520b@mail.gmail.com>
References: <20060621034857.35cfe36f.akpm@osdl.org>
	<6bffcb0e0606210407y781b3d41nef533847f579520b@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006 13:07:41 +0200
"Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:

> On 21/06/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm1/
> >
> >
> > - powerpc is bust (on g5, at least).  git-klibc is causing nash to fail on
> >   startup and some later patch is causing a big crash (I didn't bisect that
> >   one - later).
> >
> > - ia64 doesn't compile for me, due to git-klibc problems (a truly ancient
> >   toolchain might be implicated).
> >
> 
> I have the similar problem here
> 
> usr/klibc/syscalls/typesize.c:1:23: error: syscommon.h: No such file
> or directory

That one's probably just a parallel kbuild race.  Type `make' again.
