Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272287AbRIETcP>; Wed, 5 Sep 2001 15:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272288AbRIETcF>; Wed, 5 Sep 2001 15:32:05 -0400
Received: from colorfullife.com ([216.156.138.34]:49935 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S272287AbRIETbz>;
	Wed, 5 Sep 2001 15:31:55 -0400
Message-ID: <003001c13637$f6ec5870$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: <oscarcvt@galileo.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: kernel panic, a cry for help
Date: Wed, 5 Sep 2001 20:24:04 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ive started with a rescue disk, /sbin/init is present, lilo.conf seems
fine,
> where might i go next?

run fsck.
then mount the root device.
Try to chroot into the root device (could fail)
Then verify the core packages with the package manager from your distro.
(rpm -Va or rpm --root /tmp/rootmount -Va)
Then check all libraries match the installed cpu - If you upgrade to an
i686 glibc with a K6 cpu you'd run into a similar error message.

Good luck,
    Manfred



