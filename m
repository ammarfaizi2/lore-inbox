Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267484AbRGZPup>; Thu, 26 Jul 2001 11:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268138AbRGZPuf>; Thu, 26 Jul 2001 11:50:35 -0400
Received: from spring.webconquest.com ([66.33.48.187]:15876 "HELO
	mail.webconquest.com") by vger.kernel.org with SMTP
	id <S267484AbRGZPu2>; Thu, 26 Jul 2001 11:50:28 -0400
Date: Thu, 26 Jul 2001 11:50:24 -0400 (EDT)
From: <sentry21@cdslash.net>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Dan Podeanu <pdan@spiral.extreme.ro>, <linux-kernel@vger.kernel.org>
Subject: Re: Weird ext2fs immortal directory bug
In-Reply-To: <Pine.LNX.3.95.1010726114714.17653A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.30.0107261150020.18300-100000@spring.webconquest.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> > root@Petra:0:~# debugfs -w /
> > debugfs 1.22, 22-Jun-2001 for EXT2 FS 0.5b, 95/08/09
> > /: Is a directory while opening filesystem
> > debugfs:  ^D
> >
> > root@Petra:0:~# debugfs -w /dev/hda5
> > debugfs 1.22, 22-Jun-2001 for EXT2 FS 0.5b, 95/08/09
> > debugfs:  unlink /lost+found/#3147
> > debugfs:  ^D
>         ^^^^^^^^
> How about 'Q' so debugfs gets to write the modifications to the
> drive?

root@Petra:0:/lost+found# debugfs -w /dev/hda5
debugfs 1.22, 22-Jun-2001 for EXT2 FS 0.5b, 95/08/09
debugfs:  unlink /lost+found/#3147
unlink_file_by_name: No free space in the directory


This is getting weirder and weirder.


--Dan

