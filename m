Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129207AbQJaAbg>; Mon, 30 Oct 2000 19:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129416AbQJaAbR>; Mon, 30 Oct 2000 19:31:17 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:53372 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129207AbQJaAbF>; Mon, 30 Oct 2000 19:31:05 -0500
Date: Tue, 31 Oct 2000 01:30:46 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Steve Pratt/Austin/IBM <slpratt@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, linux-mm@kvack.org
Subject: Re: [PATCH] 2.4.0-test10-pre6  TLB flush race in establish_pte
Message-ID: <20001031013046.M21935@athlon.random>
In-Reply-To: <OFB4731A18.0D8D8BC1-ON85256988.0074562B@raleigh.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFB4731A18.0D8D8BC1-ON85256988.0074562B@raleigh.ibm.com>; from slpratt@us.ibm.com on Mon, Oct 30, 2000 at 03:31:22PM -0600
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2000 at 03:31:22PM -0600, Steve Pratt/Austin/IBM wrote:
> [..] no patch ever
> appeared. [..]

You didn't followed l-k closely enough as the strict fix was submitted two
times but it got not merged. (maybe because it had an #ifdef __s390__ that was
_necessary_ by that time?)

You can find the old and now useless patch here:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.0-test5/tlb-flush-smp-race-1

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
