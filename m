Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265343AbSJXHyb>; Thu, 24 Oct 2002 03:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265344AbSJXHya>; Thu, 24 Oct 2002 03:54:30 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60208 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S265343AbSJXHy3>; Thu, 24 Oct 2002 03:54:29 -0400
To: Amol Kumar Lad <amolk@ishoni.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gzip compression of vmlinux
References: <1035243705.2202.3.camel@amol.in.ishoni.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 24 Oct 2002 01:58:51 -0600
In-Reply-To: <1035243705.2202.3.camel@amol.in.ishoni.com>
Message-ID: <m1d6q0s1xg.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amol Kumar Lad <amolk@ishoni.com> writes:

> Hi,
>  Currently we use gzip to compress vmlinux ( and finally form bzImage).
> I am planning to replace it with bzip2 . Should I go ahead with it ?
> Will it find its place in the latest kernel ? 
> We save some 35k of compressed bzImage using bzip2

You might also want to take a look at upx.  It's compressor
is roughly of the same quality as gzip, but it's decompresser
is only a couple of hundred bytes.  I don't know which will
buy you more in practice.  I smaller decompresser, or a larger
decompresser with that compresses a little smaller.  Or possibly
you just want to pass -9 to gzip?

Eric

