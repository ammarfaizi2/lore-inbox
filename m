Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281044AbRKCVSt>; Sat, 3 Nov 2001 16:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281043AbRKCVSi>; Sat, 3 Nov 2001 16:18:38 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:14962 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S281042AbRKCVS1>; Sat, 3 Nov 2001 16:18:27 -0500
Date: Sat, 3 Nov 2001 22:18:26 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.14pre7aa2 [Re: 2.4.14pre7aa1]
Message-ID: <20011103221826.A1898@athlon.random>
In-Reply-To: <20011103204217.A2650@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011103204217.A2650@athlon.random>; from andrea@suse.de on Sat, Nov 03, 2001 at 08:42:17PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 03, 2001 at 08:42:17PM +0100, Andrea Arcangeli wrote:
> Only in 2.4.14pre6aa1: 10_vm-10
> Only in 2.4.14pre7aa1: 10_vm-11
> 
> 	Latest vm updates. Merged Linus changes in mainline, also the VM_LOCKED
> 	one on l-k that certainly make sense to avoid inactive cache pollution.
> 	Now keeping dirty swap cache around like pre7 does, dubious
> 	optimization though but I want to see if it makes big differences.
> 	Fixed three vm corruption bugs (one longstanding pre-2.4.9). Good

Due a merging error the fix for one of the three races was missing, so
it's now included in pre7aa2.

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.14pre7aa2.bz2
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.14pre7aa2/

Only in 2.4.14pre7aa1: 10_vm-11
Only in 2.4.14pre7aa2: 10_vm-12

	Really merged the fix for one of the races now.

Andrea
