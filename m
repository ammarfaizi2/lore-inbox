Return-Path: <linux-kernel-owner+willy=40w.ods.org-S274426AbUKAQFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274426AbUKAQFl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 11:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274366AbUKAQFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 11:05:14 -0500
Received: from sweetums.bluetronic.net ([24.199.150.42]:21235 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S274356AbUKAQEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 11:04:54 -0500
Date: Mon, 1 Nov 2004 11:02:11 -0500 (EST)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Olaf Hering <olh@suse.de>
cc: Christoph Hellwig <hch@infradead.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Disambiguation for panic_timeout's sysctl
In-Reply-To: <20041101120704.GB24626@suse.de>
Message-ID: <Pine.GSO.4.33.0411011057310.9358-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Nov 2004, Olaf Hering wrote:
>> And why should applications care for the panic timeout?  Especially only
>> a few days after it's been added to the kernel?
>
>/proc/sys/kernel/panic exists since at least 2.6.5.
>Its used to override the silly default '0' on i386, but one should be
>able to boot with panic=$bignum

/proc/sys/kernel/panic has been around for YEARS:

  [cramer:ttyp0]dominion:~/[10:52am]:uname -a
  Linux dominion 2.3.42-SMP #11 SMP Sun Feb 6 20:06:02 EST 2000 i686
                                    ^^^^^^^^^^^^^^^^^^^^^^ ****
  [cramer:ttyp0]dominion:~/[10:52am]:ls -l /proc/sys/kernel/panic
  -rw-r--r--   1 root     root            0 Nov  1 10:52 /proc/sys/kernel/panic

And that's the oldest kernel I happen to have running at the moment.

--Ricky


