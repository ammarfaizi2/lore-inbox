Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130415AbRAJAbP>; Tue, 9 Jan 2001 19:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130548AbRAJAbF>; Tue, 9 Jan 2001 19:31:05 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:15154 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130415AbRAJAax>; Tue, 9 Jan 2001 19:30:53 -0500
Date: Wed, 10 Jan 2001 01:31:09 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Sasi Peter <sape@iq.rulez.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.19pre6aa1 degraded performance for me...
Message-ID: <20010110013109.N29904@athlon.random>
In-Reply-To: <Pine.LNX.4.30.0101090722580.22161-100000@iq.rulez.org> <Pine.LNX.4.30.0101100106160.25024-100000@iq.rulez.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0101100106160.25024-100000@iq.rulez.org>; from sape@iq.rulez.org on Wed, Jan 10, 2001 at 01:07:55AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2001 at 01:07:55AM +0100, Sasi Peter wrote:
> I thought it over again. I still have to say it is a nonsense for a kernel
> not to  have _anything_ (zero pages) currently unused swapped out under
> such an I/O load!

Could you generate some furhter memory pressure to see what happens? Do you
confirm that you get the same performance as with your previous kernel if the
idle servers gets swapped out or if you shutdown them?

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
