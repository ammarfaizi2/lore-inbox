Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbRACPOB>; Wed, 3 Jan 2001 10:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129572AbRACPNw>; Wed, 3 Jan 2001 10:13:52 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:23805 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129383AbRACPNm>; Wed, 3 Jan 2001 10:13:42 -0500
Date: Wed, 3 Jan 2001 12:42:57 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
cc: J Sloan <jjs@toyota.com>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: LVM 0_9-1 woes on 2.4.0-prerelease+diffs
In-Reply-To: <20010102225844.E7563@athlon.random>
Message-ID: <Pine.LNX.4.21.0101031242220.1403-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jan 2001, Andrea Arcangeli wrote:
> On Tue, Jan 02, 2001 at 12:09:32PM -0800, J Sloan wrote:
> > # vgscan
> > vgscan: error while loading shared libraries: vgscan: undefined symbol:
> > lvm_remove_recursive
> 
> This looks like an userspace compilation/installation problem of the new lvm
> tools. Make sure you removed the old (0.8*) shared librarians. You can check
> which librarains you're using with:
> 
> 	ldd `which vgscan`

Get claudio's combined LVM RPMS (which support both the
old and the new kernel interface).

http://distro.conectiva.com.br/experimental/lvm/

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
