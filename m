Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129112AbQKNPOq>; Tue, 14 Nov 2000 10:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129466AbQKNPOg>; Tue, 14 Nov 2000 10:14:36 -0500
Received: from chaos.analogic.com ([204.178.40.224]:56194 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129112AbQKNPOV>; Tue, 14 Nov 2000 10:14:21 -0500
Date: Tue, 14 Nov 2000 09:43:54 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Keith Owens <kaos@ocs.com.au>, linux-kernel <linux-kernel@i405.com>,
        linux-kernel@vger.kernel.org
Subject: Re: newbie, 2.4.0-test11-pre4 no compile when CONFIG_AGP=y
In-Reply-To: <3A114955.3B58479A@mandrakesoft.com>
Message-ID: <Pine.LNX.3.95.1001114093947.22448A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2000, Jeff Garzik wrote:

> Keith Owens wrote:
> > 
> > On Tue, 14 Nov 2000 00:56:13 -0800,
> > linux-kernel <linux-kernel@i405.com> wrote:
> > >I'll preface this saying I'm a kernel compile newbie and I could be making
> > >the most basic of mistakes.
> > 
> > You are.  Hand editing the .config file gives undefined results.  Make
> > all changes through menuconfig or xconfig.  The config system does lots
> > of work behind the scenes which is not peformed if you hand edit.
> 
> Hand editing works just fine...   You just have to remember to run "make
> oldconfig" afterwards.
> 
> 	Jeff

Only __sometimes__. There are "questions" that will be skipped even
in `make oldconfig` if some things are hand edited. Hand editing,
followed by `make oldconfig` works only if you know what you are doing.

I wouldn't suggest it for a "newbie'.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
