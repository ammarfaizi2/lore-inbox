Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261840AbSJ0KjJ>; Sun, 27 Oct 2002 05:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262346AbSJ0KjJ>; Sun, 27 Oct 2002 05:39:09 -0500
Received: from packet.digeo.com ([12.110.80.53]:27866 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261840AbSJ0KjJ>;
	Sun, 27 Oct 2002 05:39:09 -0500
Message-ID: <3DBBC3C0.C03D02A7@digeo.com>
Date: Sun, 27 Oct 2002 02:45:20 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Pauses in 2.5.44 (some kind of memory policy change?)
References: <200210271033.CAA02842@adam.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Oct 2002 10:45:21.0245 (UTC) FILETIME=[F290D8D0:01C27DA5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" wrote:
> 
>         I run /usr/bin/mail to read my mail box file, which has about
> 24 megabytes (in 2300 messages, mostly spam).  After this, about half
> of the time, my keyboard and mouse will intermittently stop responding
> for a second or two, maybe one or two times, and then everything
> seems to be OK.  This happens *after* the mail spool has been read.
> This did not happen in previous kernels (well, maybe 2.5.43, I can't
> quite be sure about that one).
> 
>         The mail spool is on NFS, but I suspect the culprit might be
> some kind of memory balancing change in 2.5.44.
> 

Clean pagecache usually doesn't cause much trouble...

Please send a `vmstat 1' trace which covers the episode.
