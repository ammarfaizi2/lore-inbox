Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286894AbRLWONr>; Sun, 23 Dec 2001 09:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282483AbRLWONl>; Sun, 23 Dec 2001 09:13:41 -0500
Received: from fepF.post.tele.dk ([195.41.46.135]:47771 "EHLO
	fepF.post.tele.dk") by vger.kernel.org with ESMTP
	id <S282801AbRLWOMH>; Sun, 23 Dec 2001 09:12:07 -0500
Date: Sun, 23 Dec 2001 15:11:47 +0100
From: Jens Axboe <axboe@suse.de>
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Cc: really mason_at_soo_dot_com <lnx-kern@Sophia.soo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.5.2-pre1 oddness under X
Message-ID: <20011223151147.F7438@suse.de>
In-Reply-To: <20011222164602.A20623@Sophia.soo.com> <3C250835.9010806@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C250835.9010806@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22 2001, Pierre Rousselet wrote:
> really mason_at_soo_dot_com wrote:
> 
> >Running kernel 2.5.2-pre1 compiled with gcc 3.0.3,
> >i get the following error irregularly when starting
> >X or trying to compile sawfish in an xterm:
> >
> >Inconsistency detected by ld.so: dynamic-link.h: 62: elf_get_dynamic_info: 
> >Assertion `! "bad dynamic tag"' failed!
> 
> 
> I've also seen sawfish seg-faulting at the first try of 2.5.2-pre1.

This sounds like disk corruption, it may be that the -pre1 changes are
partially broken.

I'll go take a look. IDE?

-- 
Jens Axboe

