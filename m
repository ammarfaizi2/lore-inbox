Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273811AbRIRCa7>; Mon, 17 Sep 2001 22:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273809AbRIRCat>; Mon, 17 Sep 2001 22:30:49 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2435 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S273810AbRIRCah>; Mon, 17 Sep 2001 22:30:37 -0400
Date: Mon, 17 Sep 2001 22:30:15 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Bruce Blinn <blinn@MissionCriticalLinux.com>
cc: Masoud Sharbiani <masu@cr213096-a.rchrd1.on.wave.home.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Reading Windows CD on Linux 2.4.6
In-Reply-To: <3BA669A8.812D381D@MissionCriticalLinux.com>
Message-ID: <Pine.LNX.3.95.1010917222328.18866A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Sep 2001, Bruce Blinn wrote:

> "Richard B. Johnson" wrote:
> > 
> > On Mon, 17 Sep 2001, Bruce Blinn wrote:
> > [SNIPPED...]
> > 
> > Just do `cp /dev/cdrom /tmp/foo`. ^C out when you think you have
> > enough, then use `dd` to copy a small portion of the image file.
> > 
> 
> Here are the results of the methods that were suggested for producing a
> CD image.  They all seem to fail at the same place because the resulting
> file is the same size.
> 

Okay. That's good. The guy that asked to get the image to find out what
was happening can probably use a small piece of that to find out what
is going on. It probably is a CD data + Music image where the first
readable stuff is data, followed by a music image.

You can try cdda2wav -D0,4,0, -B. You will probably get some *.wav files.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


