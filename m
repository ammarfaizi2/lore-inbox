Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262876AbVFVHwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262876AbVFVHwB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 03:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262893AbVFVHs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 03:48:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22456 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262842AbVFVGjl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 02:39:41 -0400
Date: Tue, 21 Jun 2005 23:39:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status (fuse)
Message-Id: <20050621233914.69a5c85e.akpm@osdl.org>
In-Reply-To: <E1Dkyas-0006wu-00@dorka.pomaz.szeredi.hu>
References: <20050620235458.5b437274.akpm@osdl.org>
	<E1Dkfu2-0005Ju-00@dorka.pomaz.szeredi.hu>
	<20050621142820.GC2015@openzaurus.ucw.cz>
	<E1DkkRE-0005mt-00@dorka.pomaz.szeredi.hu>
	<20050621220619.GC2815@elf.ucw.cz>
	<E1Dkyas-0006wu-00@dorka.pomaz.szeredi.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > Not so emotional argument...
>  > 
>  > System where users can mount their own filesystems should not be
>  > called "Unix" any more.
> 
>  It's not.  It's "Linux".

It would be helpful if we could have a brief description of the feature
which you're discussing here.  We discussed this a couple of months back,
but I've forgotten most of it and it was off-list I think.

Doing `grep uid fs/fuse/*.c' gets us to the implementation, yes?

Which parts are controversial?

How _should_ we implement unprivileged mounts, if not this way?
