Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbTKOImK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 03:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbTKOImK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 03:42:10 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:46607 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261336AbTKOImI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 03:42:08 -0500
To: gene.heskett@verizon.net
Cc: "Patrick Beard" <patrick@scotcomms.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9 VFAT problem
References: <20031114113224.GR21265@home.bofhlet.net>
	<200311141351.18944.gene.heskett@verizon.net>
	<87ptfura5a.fsf@devron.myhome.or.jp>
	<200311141856.17275.gene.heskett@verizon.net>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 15 Nov 2003 17:41:47 +0900
In-Reply-To: <200311141856.17275.gene.heskett@verizon.net>
Message-ID: <873ccqvx9w.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett <gene.heskett@verizon.net> writes:

> On Friday 14 November 2003 15:02, OGAWA Hirofumi wrote:
> >Gene Heskett <gene.heskett@verizon.net> writes:
> >> dd if=/dev/sda1|md5sum <--note use of the same device as to read
> >> pix. has been running for 3 or so minutes now, steadily reading
> >> the camera. I shoulda put a time in front of it!  Ok got it, heres
> >> the sum: 127945+0 records in
> >> 127945+0 records out
> >> f6c568dd1f35bb37f3d667a2ab228e2f
> >> f6c568dd1f35bb37f3d667a2ab228e2f
[...]
> However, before I rebooted, those operations felt a solid as a rock, 
> and always returned the same md5sum on a repeat.

Umm... is you talking about my request? Sorry for confusing.
Let me start next step.


>> Nov 14 09:20:34 coyote kernel: FAT: Filesystem panic (dev sda1)
>> Nov 14 09:20:34 coyote kernel:     fat_free: deleting beyond EOF
>> (i_pos 0) Nov 14 09:20:34 coyote kernel:     File system has been
>> set read-only

I want to reproduce this on my machine. Can you reproduce this easy?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
