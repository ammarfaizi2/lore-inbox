Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261957AbUKPLmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbUKPLmk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 06:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbUKPLmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 06:42:40 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:6817 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261957AbUKPLmi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 06:42:38 -0500
Date: Tue, 16 Nov 2004 12:42:08 +0100
From: Jens Axboe <axboe@suse.de>
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] documentation - nohighio
Message-ID: <20041116114208.GD26240@suse.de>
References: <aec7e5c304111602474a3103e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aec7e5c304111602474a3103e4@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16 2004, Magnus Damm wrote:
> Hello,
> 
> The kernel parameter "nohighio" seems to be gone in the code, but the
> parameter is still left in the documentation.

Ah thanks, yes that's a 2.4 debug option that is long gone.

Acked-by: Jens Axboe <axboe@suse.de>

> --- linux-2.6.10-rc2/Documentation/kernel-parameters.txt	2004-11-14 18:35:07.000000000 +0100
> +++ linux-2.6.10-rc2-no_nohighio/Documentation/kernel-parameters.txt	2004-11-16 11:37:58.201316728 +0100
> @@ -785,8 +785,6 @@
>  
>  	nofxsr		[BUGS=IA-32]
>  
> -	nohighio	[BUGS=IA-32] Disable highmem block I/O.
> -
>  	nohlt		[BUGS=ARM]
>   
>  	no-hlt		[BUGS=IA-32] Tells the kernel that the hlt


-- 
Jens Axboe

