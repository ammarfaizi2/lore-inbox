Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281090AbRKKVfK>; Sun, 11 Nov 2001 16:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281091AbRKKVfA>; Sun, 11 Nov 2001 16:35:00 -0500
Received: from mail4.home.nl ([213.51.129.228]:44517 "EHLO mail4.home.nl")
	by vger.kernel.org with ESMTP id <S281090AbRKKVen>;
	Sun, 11 Nov 2001 16:34:43 -0500
Content-Type: text/plain; charset=US-ASCII
From: elko <elko@home.nl>
Organization: ElkOS
To: joeja@mindspring.com
Subject: Re: loop back broken in 2.2.14
Date: Sun, 11 Nov 2001 22:36:11 +0100
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <3BEEED3E.58867BFE@mindspring.com>
In-Reply-To: <3BEEED3E.58867BFE@mindspring.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011111213458.KGDR13960.mail4.home.nl@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 November 2001 22:27, Joe wrote:
> compile 2.2.14.
>
> Then
>
> # modprobe -a loop
> /lib/modules/2.4.14/kernel/drivers/block/loop.o: unresolved symbol
> deactivate_page
> /lib/modules/2.4.14/kernel/drivers/block/loop.o: insmod
> /lib/modules/2.4.14/kernel/drivers/block/loop.o failed
> /lib/modules/2.4.14/kernel/drivers/block/loop.o: insmod loop failed
>
> do recursive grep through kernel tree:
>
> # rgrep -rl  deactivate_page *
> drivers/block/loop.c
> drivers/block/loop.o
>
> Is there a fix for this?

2.4.15-pre1 fixed this and there are also some patches on lkml-archives..
-- 
ElkOS: 10:35pm up  2:26, 3 users, load average: 0.05, 0.25, 0.30
bofhX: The data on your hard drive is out of balance.

