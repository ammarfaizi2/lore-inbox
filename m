Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264964AbTK3RzD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 12:55:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264965AbTK3RzD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 12:55:03 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:1489 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264964AbTK3RzA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 12:55:00 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: James Buchanan <jamesb.au@acm.org>
Subject: Re: kernel 2.6.0-test10 panic, VFS mount root failed
Date: Sun, 30 Nov 2003 18:56:09 +0100
User-Agent: KMail/1.5.4
References: <1070213861.6254.7.camel@redhat.localdomain>
In-Reply-To: <1070213861.6254.7.camel@redhat.localdomain>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311301856.09886.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Check if you have IDE support for your hardware compiled-in.
'dmesg' outputs from 2.6.0-test10 and RH8.0 would be useful.

--bart

On Sunday 30 of November 2003 18:37, James Buchanan wrote:
> Hi,
>
> I keep getting a 2.6.0-test10 kernel panic when VFS attempts to mount
> the root filesystem.
>
> In my grub script I have:
> root (hd0,1)
> kernel /boot/vmlinuz-2.6.0-test10 ro root=/dev/hda2
>
> which is correct for my system.  The kernel then panics and tells me
> 'hda2' is not good and to pass a correct boot= option to the kernel.
> The exact message doesn't mean anything to me - it doesn't say something
> like 'don't have ext3 fs compiled in.'
>
> My RedHat Linux 8 system boots fine on the same partition with
> boot=LABEL=/.  I thought it could have been that I didn't compile ext3
> into the kernel, but after double checking, yes it's there.  That's all
> I can think of, is there something else I might be missing?
>
> Thanks,
> James

