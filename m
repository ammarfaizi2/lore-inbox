Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264681AbUEJM4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264681AbUEJM4n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 08:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264682AbUEJM4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 08:56:43 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:58057 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264681AbUEJM4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 08:56:42 -0400
Date: Mon, 10 May 2004 14:56:36 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Chris Wedgwood <cw@f00f.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andreas Gruenbacher <agruen@suse.de>,
       Nathan Scott <nathans@sgi.com>
Subject: Re: [PATCH] 2.6.6 Have XFS use kernel-provided qsort
Message-ID: <20040510125636.GJ9028@fs.tum.de>
References: <20040510050905.GB13889@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040510050905.GB13889@taniwha.stupidest.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 09, 2004 at 10:09:05PM -0700, Chris Wedgwood wrote:
>...
> diff -Nru a/fs/xfs/support/qsort.c b/fs/xfs/support/qsort.c
> --- a/fs/xfs/support/qsort.c	Sun May  9 20:27:31 2004
> +++ b/fs/xfs/support/qsort.c	Sun May  9 20:27:31 2004
>...

This results in an empty file being left.

When removing a file, the second should either have the epoch as date, 
or it should be /dev/null, e.g.:

  diff -Nru a/fs/xfs/support/qsort.c /dev/null

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

