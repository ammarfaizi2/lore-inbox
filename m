Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130140AbRABMqB>; Tue, 2 Jan 2001 07:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130749AbRABMpm>; Tue, 2 Jan 2001 07:45:42 -0500
Received: from renata.irb.hr ([161.53.129.148]:2577 "EHLO renata.irb.hr")
	by vger.kernel.org with ESMTP id <S130140AbRABMpf>;
	Tue, 2 Jan 2001 07:45:35 -0500
From: Vedran Rodic <vedran@renata.irb.hr>
Date: Tue, 2 Jan 2001 13:15:07 +0100
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-prerelease problems (it corrupted my ext2 filesystem)
Message-ID: <20010102131507.A7573@renata.irb.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I was using 2.4.0-prerelease without extra patches and I experienced some
heavy (ext2) file system corruption. I was grabbing some video using bttv at 
the time. Kernel didn't oops, but processess just started terminating.


Here is a the interesting part from my logs:

Bad swap file entry 5c5b6256
VM: killing process qtvidcap
swap_free: Trying to free nonexistent swap-page
last message repeated 23 times
swap_free: Trying to free swap from unused swap-device
swap_free: Trying to free nonexistent swap-page
last message repeated 266 times
Bad swap file entry 272c2e24
VM: killing process pppd
swap_free: Trying to free nonexistent swap-page
last message repeated 30 times

Vedran Rodic
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
