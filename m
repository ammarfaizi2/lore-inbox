Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283807AbRLEIqr>; Wed, 5 Dec 2001 03:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283827AbRLEIqh>; Wed, 5 Dec 2001 03:46:37 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:18496 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S283807AbRLEIqW>; Wed, 5 Dec 2001 03:46:22 -0500
Date: Wed, 5 Dec 2001 09:46:32 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Cyrille Chepelov <cyrille@chepelov.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Gradual VM-related freeze in 2.4.16,17-pre2 !
Message-ID: <20011205094632.Q3447@athlon.random>
In-Reply-To: <20011205055509.GB11283@calixo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011205055509.GB11283@calixo.net>; from cyrille@chepelov.org on Wed, Dec 05, 2001 at 06:55:09AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2001 at 06:55:09AM +0100, Cyrille Chepelov wrote:
> Hi folks,
> 
> I've converted yesterday my router, which until now had been happily running
> ext2+2.4.13-pre2 on 8 MB of RAM + 200 MB of swap, to the ext3 + 2.4.16 (and
> 2.4.17-pre2) combinations (still eight megs of RAM, unfortunately 8-bit
> SIMMs ain't cheap nowadays).
> 
> Now, as soon as the system gets some use (inetd kicks exim in, one ssh
> attempt, etc.), most processes go freeze themselves into 
>   <shrink_caches +57/80>

I never reproduced anything wrong here, testing on highmem and non
highmem. Just in case can you also reproduce with 2.4.17pre1aa1?

Andrea
