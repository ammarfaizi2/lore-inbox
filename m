Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbTJFQKl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 12:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262377AbTJFQKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 12:10:41 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:26047 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262375AbTJFQKc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 12:10:32 -0400
Date: Mon, 6 Oct 2003 18:10:13 +0200
From: Jens Axboe <axboe@suse.de>
To: Felipe W Damasio <felipewd@terra.com.br>
Cc: Alexey Dobriyan <adobriyan@mail.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] check copy_from_user return value in sony535
Message-ID: <20031006161013.GD972@suse.de>
References: <E1A6XJm-0003Vi-00.adobriyan-mail-ru@f20.mail.ru> <3F8192E6.1010302@terra.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F8192E6.1010302@terra.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 06 2003, Felipe W Damasio wrote:
> 	Hi Alexey,
> 
> Alexey Dobriyan wrote:
> >Fell free to nuke verify_area() right before 'return err;' ;-)
> 
> 	Right :)
> 
> >Moving copy_from_user() before spin_up_drive() then also seems right thing 
> >to do.
> 
> 	Oh, ok.
> 
> 	Jens, please apply this patch instead.

Too late, if you have other changes make them against current BK. I'd
say this one is cosmetic, though.

-- 
Jens Axboe

