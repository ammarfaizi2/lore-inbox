Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277710AbRJ1FFx>; Sun, 28 Oct 2001 01:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277703AbRJ1FFo>; Sun, 28 Oct 2001 01:05:44 -0400
Received: from [24.69.198.229] ([24.69.198.229]:60171 "HELO
	gandalf.vi.bravenet.com") by vger.kernel.org with SMTP
	id <S277702AbRJ1FFb>; Sun, 28 Oct 2001 01:05:31 -0400
Date: Sat, 27 Oct 2001 22:25:50 -0700 (PDT)
From: Dan <dphoenix@bravenet.com>
To: Ed Tomlinson <tomlins@CAM.ORG>
cc: <linux-kernel@vger.kernel.org>, <reiserfs-list@namesys.com>
Subject: Re: [reiserfs-list] 2.4.14-pre3 and umount
In-Reply-To: <20011028045744.BE5C22A109@oscar.casa.dyndns.org>
Message-ID: <20011027222520.U97690-100000@gandalf.bravenet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



might have a process accessing /back?
lsof|grep back



On Sun, 28 Oct 2001, Ed Tomlinson wrote:

> Date: Sun, 28 Oct 2001 00:57:41 -0400
> From: Ed Tomlinson <tomlins@CAM.ORG>
> To: linux-kernel@vger.kernel.org
> Cc: reiserfs-list@namesys.com
> Subject: [reiserfs-list] 2.4.14-pre3 and umount
>
> Hi,
>
> I am running 2.4.14-pre3 patched with LVM 1.01rc4 and the vfs locking patch
> for 2.4.11 and above.  I performed the following actions after which umount
> fails.
>
> mount /back
> cd /back
> ran a backup which filled the reiserfs on lvm /back fs.
> cd ..
> umount /back
>
> and the umount tells me /back is busy.  Why? Does anyone
> else see this behavior?  With straight 2.4.14-pre3?
>
> TIA,
> Ed Tomlinson (off to sleep now)
>

