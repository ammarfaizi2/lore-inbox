Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbWBBVGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWBBVGq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 16:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWBBVGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 16:06:46 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:51296 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932246AbWBBVGp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 16:06:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ziqa+0AKu9qlV8oErE0ohdlr4jH8c6TwqEDBb+wU0o246aoUQb0MHzmwhLyM7k4x4QkAuOZlMv0oApymaqlzgnSAK3uKKi/KmXCSRPU2CJpUYZJEo89lxH0hrT+FiCWOB/VUgiGG3fZnfWTJPIL3yCZSGDFiR9q1At9iBdg+wkw=
Message-ID: <6bffcb0e0602021306l6b6c1423r@mail.gmail.com>
Date: Thu, 2 Feb 2006 22:06:43 +0100
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-rc1-mm3
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <20060201005106.35ca4b8c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060124232406.50abccd1.akpm@osdl.org>
	 <6bffcb0e0601250340x6ca48af0w@mail.gmail.com>
	 <43D7A047.3070004@yahoo.com.au>
	 <6bffcb0e0601261102j7e0a5d5av@mail.gmail.com>
	 <43D92754.4090007@yahoo.com.au> <43D927F6.9080807@yahoo.com.au>
	 <6bffcb0e0601270211v787f91d2r@mail.gmail.com>
	 <43E0718F.1020604@yahoo.com.au>
	 <20060201005106.35ca4b8c.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01/02/06, Andrew Morton <akpm@osdl.org> wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
[snip]
> > Andrew this one looks unrelated -
> >  have you seen anything similar?
>
> No, I don't think I have.
>
> > Any ideas?
>
> This has a greggy feel to it.  udev is trying to read a symlink in sysfs,
> probably USB-related, but it hit a bad address.  It might boot OK without
> CONFIG_DEBUG_PAGEALLOC.
>
> Michal, it'd be useful to look up 0xb0161cdd in gdb, see what line it died
> at.
>

Here is output form gdb:
http://www.stardust.webpages.pl/files/mm/2.6.16-rc1-mm3/mm-do_path_lookup

Regards,
Michal Piotrowski

PS. Sorry for late answer, but I have some exams and I don't have many
free time.
