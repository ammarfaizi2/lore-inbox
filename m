Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261835AbVBIPpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbVBIPpj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 10:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVBIPpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 10:45:39 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30341 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261835AbVBIPpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 10:45:34 -0500
Date: Wed, 9 Feb 2005 10:10:11 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Todd Shetter <tshetter-lkml@earthlink.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x kernel BUG at filemap.c:81
Message-ID: <20050209121011.GA13614@logos.cnet>
References: <42099C57.9030306@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42099C57.9030306@earthlink.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2005 at 12:15:03AM -0500, Todd Shetter wrote:
> Running slackware 10 and 10.1, with kernels 2.4.26, 2.4.27, 2.4.28, 
> 2.4.29 with highmem 4GB, and highmem i/o support enabled, I get a system 
> lockup. This happens in both X and console. Happens with and without my 
> Nvidia drivers loaded. I cannot determine what makes this bug present it 
> self besides highmem and high i/o support enabled. Im guessing the 
> system is fine until highmem is actually used to some point and then it 
> borks, but I really have no idea and so im just making a random guess. I 
> ran memtest86 for a few hours a while ago thinking that it may be bad 
> memory, but that did not seem to be the problem.
> 
> If you need anymore information, or have questions, or wish me to test 
> anything, PLEASE feel free to contact me, I would really like to see 
> this bug resolved. =)
> 
> --
> Todd Shetter
> 
> 
> Feb  8 19:49:31 quark kernel: kernel BUG at filemap.c:81!
> Feb  8 19:49:31 quark kernel: invalid operand: 0000
> Feb  8 19:49:31 quark kernel: CPU:    0
> Feb  8 19:49:31 quark kernel: EIP:    0010:[<c01280d1>]    Tainted: P

Hi Todd, 

Why is your kernel tainted ?
