Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315899AbSEGPig>; Tue, 7 May 2002 11:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315898AbSEGPie>; Tue, 7 May 2002 11:38:34 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:17428 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315897AbSEGPiF>; Tue, 7 May 2002 11:38:05 -0400
Date: Tue, 7 May 2002 17:38:57 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andy Carlson <naclos@andyc.dyndns.org>, linux-kernel@vger.kernel.org
Subject: Re: Tux in main kernel tree? (was khttpd rotten?)
Message-ID: <20020507173857.R31998@dualathlon.random>
In-Reply-To: <20020507170331.P31998@dualathlon.random> <E1756qo-0007mw-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2002 at 04:26:02PM +0100, Alan Cox wrote:
> which Linus rejected because they put TuX specific code in places like
> the dcache where from a pure clean kernel point of view it is 

not a good example, that is been cleanedup in latest tux releases,
there's no tux specific code anymore in the dcache:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre8aa2/60_tux-vfs-5

there are still a a few lines of tux in the task struct and the socks
but it doesn't really matter to the non tux users, and it obviously
cannot affect stability in any way.

Andrea
