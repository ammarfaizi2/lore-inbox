Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130198AbQKYSJI>; Sat, 25 Nov 2000 13:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130839AbQKYSI6>; Sat, 25 Nov 2000 13:08:58 -0500
Received: from zeus.kernel.org ([209.10.41.242]:25094 "EHLO zeus.kernel.org")
        by vger.kernel.org with ESMTP id <S130198AbQKYSIm>;
        Sat, 25 Nov 2000 13:08:42 -0500
Date: Sat, 25 Nov 2000 18:20:56 +0100 (CET)
From: Arjan Filius <iafilius@xs4all.nl>
Reply-To: Arjan Filius <iafilius@xs4all.nl>
To: Eugene Crosser <crosser@average.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test11: "_isofs_bmap: block < 0"
In-Reply-To: <8vd0cb$5a0$1@pccross.average.org>
Message-ID: <Pine.LNX.4.21.0011251818550.9351-100000@sjoerd.sjoerdnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Same here with CD 1 from SuSE 7.0-DE :
Nov 25 18:16:03 sjoerd kernel: VFS: Disk change detected on device ide1(22,64)
Nov 25 18:16:05 sjoerd kernel: ISO 9660 Extensions: RRIP_1991A
Nov 25 18:16:05 sjoerd kernel: _isofs_bmap: block < 0

Using test11 and everything is a module.


On 21 Nov 2000, Eugene Crosser wrote:

> I have a cdrom with iso9660+RR filesystem, with a few hundred files in
> ten directories.  With all previous kernels (checked up to test11-pre3),
> I had no problems with it.  With test11 final, "ls" command shows
> zero entries on the mounted CD, and each "ls" attempt causes this
> kernel message:
> 
> _isofs_bmap: block < 0
> 
> If I open a file directly, it opens and is read fine, so it's only
> readdir() that is not working.  Tell me if I need to provide more info.
> 
> Eugene
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-- 
Arjan Filius
mailto:iafilius@xs4all.nl

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
