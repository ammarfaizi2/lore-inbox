Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289360AbSAOAxl>; Mon, 14 Jan 2002 19:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289101AbSAOAx0>; Mon, 14 Jan 2002 19:53:26 -0500
Received: from mx3.sac.fedex.com ([199.81.208.11]:7947 "EHLO mx3.sac.fedex.com")
	by vger.kernel.org with ESMTP id <S289344AbSAOAxE>;
	Mon, 14 Jan 2002 19:53:04 -0500
Date: Tue, 15 Jan 2002 08:50:37 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Linux Kernel <linux-kernel@vger.kernel.org>,
        "Richard B. Johnson" <root@chaos.analogic.com>
Subject: Re: initrd failure on Linux-2.4.17
In-Reply-To: <Pine.LNX.3.95.1020114103203.216A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.43.0201150846320.29728-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 01/15/2002
 08:52:59 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 01/15/2002
 08:53:02 AM,
	Serialize complete at 01/15/2002 08:53:02 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002, Richard B. Johnson wrote:
> RAMDISK: Compressed image found at block 0
> Freeing initrd memory: 581k freed
> kernel panic: VFS: Unable to mount root fs on 01:00
>
> Has somebody fixed this or is it expected that nobody uses
> an initial RAM disk on 2.4.17 ..or.. is this not the latest
> "stable" version of Linux to use?

RAMDISK: Compressed image found at block 0
Freeing initrd memory: 5384k freed
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 172k freed

I booted with Linux-2.4.0 up to 2.4.18-pre3.

Did you specify root=/dev/hda2 in your boot file?


Jeff.

