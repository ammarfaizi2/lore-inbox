Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbWEXTl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbWEXTl6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 15:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWEXTl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 15:41:58 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:11910 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751288AbWEXTl5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 15:41:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Ej1SMTdO7v/s/rACJAxcuz1FMYudEy/NXqssCBjvkufuAGkhoWRDsh03Oh8tMBYFKNn/deE6iwn6tdqUvTRqwFrul817HqmAbBMkBhDXdDbbPGEsPFY254vyHJQj5Q5iNfkiSlQ7ksv82VeYf0ZTgAzu3+R3ZicMVWEfI1kHxR0=
Message-ID: <91740af30605241241g3dc06954p3e6d5571185d15b5@mail.gmail.com>
Date: Wed, 24 May 2006 15:41:57 -0400
From: "Rohan Mutagi" <rohan208@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: linux 2.6.16.1 and kdb "error 6 mounting ext3"
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Guys,
 I am getting a -

"Kernel panic - not syncing: attempted to kill init!"

error when I try to run 2.6.16 kernel compiled with kdb support. Any
ideas how to proceded further into this problem?

Steps I took were:
1. Got a fresh 2.6.16.1 kernel
2. Applied the kdb patch from ftp://oss.sgi.com/www/projects/kdb/download/v4.4/
3. make clean; make; make modules_install install; reboot;

I am running this Linux RHEL inside VMWare. Now when I reboot to the
2.6.16-kgb kernel..
I get the following error after I choose the 2.6.16 kernel from grub!
__________________________________
Red Hat nash version 4.2.1.6 starting
  Reading all physical volumes. This may take a while...
  No volume groups found
  Unable to find volume group "VolGroup00"
ERROR: /bin/lvm exited abnormally! (pid 304)
mount: error 6 mounting ext3
mount: error 2 mounting none
switchroot: mount failed: 22
umount /initrd/dev failed: 2
Kernel panic - not syncing: attempted to kill init!

entering kdb due to KDB_ENTER()
kdb>
_____________________________________

I an provide the screen shot(60k), but not sure if posting screen
shots is recommended, so didn't post it.

However, when I boot up with the older kernel. everything works fine.
Any ideas whats the problem or how to proceed further?

Thanks a lot for your time,
Rohan Mutagi
