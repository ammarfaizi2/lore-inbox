Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbWAFP0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbWAFP0b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 10:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWAFP0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 10:26:31 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:58149 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932351AbWAFP0a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 10:26:30 -0500
Date: Fri, 6 Jan 2006 16:28:06 +0100
From: Jens Axboe <axboe@suse.de>
To: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
Cc: akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bio: gcc warning fix.
Message-ID: <20060106152806.GQ3389@suse.de>
References: <20060106130729.31561730.lcapitulino@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060106130729.31561730.lcapitulino@mandriva.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06 2006, Luiz Fernando Capitulino wrote:
> 
>  Fixes the following gcc 4.0.2 warning:
> 
> fs/bio.c: In function 'bio_alloc_bioset':
> fs/bio.c:167: warning: 'idx' may be used uninitialized in this function
> 
> Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

NACK, the warning is bogus.

-- 
Jens Axboe

