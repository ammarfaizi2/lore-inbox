Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266150AbUA1UYs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 15:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266152AbUA1UYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 15:24:48 -0500
Received: from 213-84-216-119.adsl.xs4all.nl ([213.84.216.119]:64392 "EHLO
	morannon.frodo.local") by vger.kernel.org with ESMTP
	id S266150AbUA1UYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 15:24:46 -0500
From: Frodo Looijaard <frodol@dds.nl>
Date: Wed, 28 Jan 2004 21:24:43 +0100
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH to access old-style FAT fs
Message-ID: <20040128202443.GA9246@frodo.local>
References: <20040126173949.GA788@frodo.local> <bv3qb3$4lh$1@terminus.zytor.com> <87n0898sah.fsf@devron.myhome.or.jp> <4016B316.4060304@zytor.com> <87ad4987ti.fsf@devron.myhome.or.jp> <20040128115655.GA696@arda.frodo.local> <87y8rr7s5b.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y8rr7s5b.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 29, 2004 at 05:08:32AM +0900, OGAWA Hirofumi wrote:
> 
> "stop when DIR_Name[0] == 0" should be added after cleanup. The option
> is not needed.

OK. That would be nice. Like I said, I just hope it does not break other
FAT implementations, but that is not very likely. At least, that would
allow read-only mounted EPOC FAT partitions to be handled correctly.
 
> Honestly, I wouldn't like to add the "add a new DIR_Name[0] = 0" part.
> The option is added easy, but it is not removed easy. And we must
> maintain it. 

I understand. I could always maintain that patch separately for those
who need it (for read-write mounted EPOC FAT partitions).

> (BTW, looks like that patch is buggy)

Could well be. Any suggestions what to look out for?

Thanks,
  Frodo

-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.
