Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129370AbQLKJXT>; Mon, 11 Dec 2000 04:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130281AbQLKJXJ>; Mon, 11 Dec 2000 04:23:09 -0500
Received: from c334580-a.snvl1.sfba.home.com ([65.5.27.33]:5 "HELO
	mail.hislinuxbox.com") by vger.kernel.org with SMTP
	id <S129370AbQLKJW7>; Mon, 11 Dec 2000 04:22:59 -0500
Message-ID: <01ae01c0634f$c2dcf280$0400a8c0@playtoy>
From: "David D.W. Downey" <pgpkeys@hislinuxbox.com>
To: <jamagallon@able.es>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0012100306530.4353-100000@playtoy.hislinuxbox.com> <20001211005821.A2556@werewolf.able.es>
Subject: Re: No shared memory??
Date: Mon, 11 Dec 2000 00:52:05 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah I just read that. Thanks for the info. Knew nothing about it being
kicked out there. I usually only read looking for package locations of
needed software to run the kernels. Now it looks like I should be reading
more. Thanks for the blow to the head to get me thinking right again. :)

BTW, I have that mounted now like the docs say but I still do not get any
shared info. I've gotten a couple of other emails about it, one of which
states that it ate up too much CPU time.

What I'm wondering is, is it possible to get that info some other way? I
realize walking the process tree is a pain in the ass and expensive CPU and
time wise. Also, I'm not sure if that information would include each
process's private memory space.

The reason I'm asking is that taking the overall memory used, subtracting
the cached and buffered memory may not always leave the right amount of
shared memory.

(If I show 26MB used total, 21MB which is cached and 1MB that's buffered is
it a FACT that the remaining 4MB unaccounted for is actually and completely
shared memory?)

Any other information on this would be appreciated.

TO THE KERNEL DEVELOPERS
=========================
BTW, I love the devfs stuff. REALLY makes s big difference. I'm developing
my own flavor of linux and it's quickly being modified to use ONLY devfs
entries.


>
> On Sun, 10 Dec 2000 12:11:14 David D.W. Downey wrote:
> >
> > OK, got a tiny little bug here.
> >
> > When running top, procinfo, or free I get 0 for Shared memory. Obviously
> > this is incorrect. What has changed from the 2.2.x and the 2.4.x that
> > would cause these apps to misreport this information.
> >
>
> Have you mounted /dev/shm (shared memory) filesystem ?
> Take a look at kernel documentation under linux/Documentation/Changes.
>
> --
> Juan Antonio Magallon Lacarta                                 #> cd /pub
> mailto:jamagallon@able.es                                     #> more beer
>
> Linux werewolf 2.2.18-pre25-vm #4 SMP Fri Dec 8 01:59:48 CET 2000 i686
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
