Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261585AbUJaLwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbUJaLwx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 06:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261574AbUJaLrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 06:47:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:26298 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261550AbUJaLLt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 06:11:49 -0500
Date: Sun, 31 Oct 2004 03:09:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: geert@linux-m68k.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: [PATCH 475] HP300 LANCE
Message-Id: <20041031030931.3d592bf2.akpm@osdl.org>
In-Reply-To: <20041031105724.GA28012@havoc.gtf.org>
References: <200410311003.i9VA3UMN009557@anakin.of.borg>
	<4184BB09.8000107@pobox.com>
	<20041031021933.1eba86a6.akpm@osdl.org>
	<4184C16E.80705@pobox.com>
	<20041031024840.6eeee92d.akpm@osdl.org>
	<20041031105724.GA28012@havoc.gtf.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> On Sun, Oct 31, 2004 at 02:48:40AM -0800, Andrew Morton wrote:
>  > > -        void *va = dio_scodetoviraddr(scode);
>  > > +	unsigned long pa = dio_scodetophysaddr(scode);
>  > > +        unsigned long va = (pa + DIO_VIRADDRBASE);
> 
> 
>  > That's because the stoopid driver is using spaces instead of tabs all over
>  > the place.  It comes out visually OK once the patch is applied.  But it's a
>  > useful reminder of how much dreck we have in the tree.
> 
>  Did you see the above quoted patch chunk?  The patch is inconsistent
>  with _itself_, adding 'pa' and 'va' with different idents (but when they
>  should be at the same identation level).

Trust me ;)

http://www.zip.com.au/~akpm/linux/patches/stuff/x.jpg
