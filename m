Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289727AbSBXFBM>; Sun, 24 Feb 2002 00:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293283AbSBXFBD>; Sun, 24 Feb 2002 00:01:03 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:20997
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S289727AbSBXFAy>; Sun, 24 Feb 2002 00:00:54 -0500
Date: Sat, 23 Feb 2002 20:48:29 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@suse.de>
Subject: Re: ide timer trbl ...
In-Reply-To: <Pine.LNX.4.44.0202231238060.1449-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.10.10202232046060.5715-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Feb 2002, Davide Libenzi wrote:

> 
> You guys probably already know but i'm still having problems with the ide
> timer in 2.5.5 :
> 
> hda: ide_set_handler: handler not null; old=c01c5e10, new=c01c5e10
> bug: kernel timer added twice at c01c7293.
> NFS: NFSv3 not supported.
> nfs warning: mount version older than kernel
> hda: ide_set_handler: handler not null; old=c01c5e10, new=c01c5e10
> bug: kernel timer added twice at c01c7293.
> 
> 
> The machine seems working fine but i get these messages at the end of the
> kernel boot sequence. If you need more info just let me know.

I know the issue because I just found it before you sent this post.
I will generate a patch for which should solve the problem.

Regards,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

