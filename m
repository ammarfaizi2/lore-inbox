Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277317AbRJUXvH>; Sun, 21 Oct 2001 19:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277320AbRJUXu4>; Sun, 21 Oct 2001 19:50:56 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:13641 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S277317AbRJUXuv>; Sun, 21 Oct 2001 19:50:51 -0400
Date: Mon, 22 Oct 2001 01:51:10 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: khromy <khromy@lnuxlab.ath.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.13pre5aa1
Message-ID: <20011022015110.B8408@athlon.random>
In-Reply-To: <20011021144144.A29415@lnuxlab.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011021144144.A29415@lnuxlab.ath.cx>; from khromy@lnuxlab.ath.cx on Sun, Oct 21, 2001 at 02:41:44PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2001 at 02:41:44PM -0400, khromy wrote:
> my normal load(which is gaim, xchat, gkrellm, opera, mozilla, mysql) but the
> following made it better.
> 
> echo 6 > /proc/sys/vm/vm_scan_ratio
> echo 2 > /proc/sys/vm/vm_mapped_ratio
> echo 4 > /proc/sys/vm/vm_balance_ratio

agreed, pre5aa1 was swapping too much by default, so the above echos are
recommended. btw, I did further developement in the weekend and it
should be better now by default than pre5aa1 with the above sysctl
settings.  I'll do more tests on bigger hardware in the next days (I was
on the laptop).

thanks for the feedback,

Andrea
