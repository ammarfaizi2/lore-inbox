Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314403AbSFQUVm>; Mon, 17 Jun 2002 16:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316974AbSFQUVl>; Mon, 17 Jun 2002 16:21:41 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32016 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314403AbSFQUVl>; Mon, 17 Jun 2002 16:21:41 -0400
Date: Mon, 17 Jun 2002 13:22:13 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.5.22 add __fput for aio
In-Reply-To: <20020617161931.E1457@redhat.com>
Message-ID: <Pine.LNX.4.44.0206171321550.3236-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Jun 2002, Benjamin LaHaise wrote:
>
> Sure.  How's changing it to:
>
> +/* __fput is called from task task when aio completion releases the last
> + * use of a struct file *.  Do not use otherwise.
> + */
>
> instead?

Much better.

		Linus

