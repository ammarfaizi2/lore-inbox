Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317117AbSIILz1>; Mon, 9 Sep 2002 07:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317169AbSIILz1>; Mon, 9 Sep 2002 07:55:27 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:37064 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S317117AbSIILz1>; Mon, 9 Sep 2002 07:55:27 -0400
Message-ID: <3D7C8D61.6070202@synertronixx.de>
Date: Mon, 09 Sep 2002 14:00:33 +0200
From: Konstantin Kletschke <kletschke@synertronixx.de>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.1b) Gecko/20020721 MultiZilla/v1.1.22
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-preX-acX ide-scsi oops
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there!

I for myself expierence the same Kernel oopses when using the ide-scsi
module and mounting cdroms the other peolpe here already mentioned.

At my box too, the kernel is not tainted, just boot, modprobe ide-scsi,
mount cdrom and oops.

I do have the same oopses using the 2.4.20-preX-acX series.
I use a Debian sarge and the gcc-3.1 (because the 3.2 does not compile
this kernel, make dep complains about a missing stdarg.h which 3.1 does
not. but thats another issue, which may be broken in the debian package
because I read some people are able to compile)

I have to use the acX series, because the hpt372 runs pretty well with
it, with vanilla kernels -> no way!

Why I am posting this is that Alan Cox is not able to reproduce the OOPS
and it is not clear where the Problem is at all.

But do you know that this Problem is not there after patching
2.4.20-pre5-ac1 with hedricks' ide-2.4.20-pre5-ac1.3?

After that my ide-scsi cdroms work like a charme, so there must be an
importand bit in hedrick's patches.

Im just curios if you know that, reading the list it doesn't seem to be
so...

Happy Hacking,
Konstantin

