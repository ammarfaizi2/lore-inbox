Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263130AbUA3LQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 06:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263513AbUA3LQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 06:16:58 -0500
Received: from intra.cyclades.com ([64.186.161.6]:41158 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263130AbUA3LQ5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 06:16:57 -0500
Date: Fri, 30 Jan 2004 09:05:08 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Urban Widmark <Urban.Widmark@enlight.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] smbfs: Large File Support (3/3) (fwd)
Message-ID: <Pine.LNX.4.58L.0401300904240.1323@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Urban?

---------- Forwarded message ----------
Date: Wed, 28 Jan 2004 14:21:53 -0500
From: Arjan van de Ven <arjanv@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] smbfs: Large File Support (3/3)

On Wed, 2004-01-28 at 06:05, Linux Kernel Mailing List wrote:

> diff -Nru a/include/linux/smb.h b/include/linux/smb.h
> --- a/include/linux/smb.h	Wed Jan 28 04:02:56 2004
> +++ b/include/linux/smb.h	Wed Jan 28 04:02:56 2004
> @@ -85,7 +85,7 @@
>  	uid_t		f_uid;
>  	gid_t		f_gid;
>  	kdev_t		f_rdev;
> -	off_t		f_size;
> +	loff_t		f_size;
>  	time_t		f_atime;
>  	time_t		f_mtime;
>  	time_t		f_ctime;

ehhmmmm doesn't this change the userspace ABI incompatibly ???
