Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282778AbRK0Duw>; Mon, 26 Nov 2001 22:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282779AbRK0Dun>; Mon, 26 Nov 2001 22:50:43 -0500
Received: from harrier.mail.pas.earthlink.net ([207.217.120.12]:44209 "EHLO
	harrier.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S282778AbRK0Duk>; Mon, 26 Nov 2001 22:50:40 -0500
Message-ID: <01b501c176f6$8bac6cd0$0a00a8c0@intranet.mp3s.com>
Reply-To: "Sean Elble" <S_Elble@yahoo.com>
From: "Sean Elble" <S_Elble@yahoo.com>
To: "Nathan G. Grennan" <ngrennan@okcforum.org>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <1006812135.1420.0.camel@cygnusx-1.okcforum.org>
Subject: Re: Unresponiveness of 2.4.16
Date: Mon, 26 Nov 2001 22:49:40 -0500
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

> I tried switching to Redhat's 2.4.9-13 kernel and it acts Alot better.
> Not only does 2.4.9-13 not get the 30 second delay, but it also seems to
> take advantage of caching. 2.4.16 takes the same moment of time each
> time, even tho it should have cached it all into memory the first time.

Unless Red Hat has specifically added Andrea's new VM code to the 2.4.9
kernel, then that kernel is still using the old VM. The 2.4.10 (?) and above
kernels all use Andrea's new VM, and this includes 2.4.16 (obviously :-). My
guess is that it is a small VM-related problem, but I am certainly not a
programmer; I did see other replies to this problem, but I accidently
deleted them before I could fully read them. :-( My suggestion would
definitely to be to try other kernels; I would personally try 2.4.10,
2.4.12, 2.4.14, and you have already tried 2.4.16. This would at the very
least tell you where the problem was introduced, and hopefully, some of the
brilliant kernel people (not me) could take over from there. Hope that
helps.

-----------------------------------------------
Sean P. Elble
Editor, Writer, Co-Webmaster
ReactiveLinux.com (Formerly MaximumLinux.org)
http://www.reactivelinux.com/
elbles@reactivelinux.com
-----------------------------------------------

----- Original Message -----
From: "Nathan G. Grennan" <ngrennan@okcforum.org>
To: <linux-kernel@vger.kernel.org>
Sent: Monday, November 26, 2001 5:02 PM
Subject: Unresponiveness of 2.4.16


> 2.4.16 becomes very unresponsive for 30 seconds or so at a time during
> large unarchiving of tarballs, like tar -zxf mozilla-src.tar.gz. The
> file is about 36mb. I run top in one window, run free repeatedly in
> another window and run the tar -zxf in a third window. I had many
> suspects, but still not sure what it is. I have tried
>
> ext2 vs ext3
> preemptive vs non-preemptive
> tainted vs non-tainted
>
> Nothing seems to help 2.4.16.
>
> I tried switching to Redhat's 2.4.9-13 kernel and it acts Alot better.
> Not only does 2.4.9-13 not get the 30 second delay, but it also seems to
> take advantage of caching. 2.4.16 takes the same moment of time each
> time, even tho it should have cached it all into memory the first time.
> 2.4.9-13 takes a while the first time(without the 30 second new process
> freezing), but then takes almost no time the times after that. One
> interesting thing I noticed is that with and without preemptive a
> already started mp3 playing had no disruption even during the 30 second
> windows where any new commands would get stuck with 2.4.16. I am not
> using custom
>
> I plan to do more testing to see how say 2.4.9, 2.4.13ac7, etc.
>
> Any ideas of how to fix this for 2.4.16?
>
> I have attached my .config.
>
> My system:
>
> Redhat 7.2 with all updates
>
> Athlon Thunderbird 1.33ghz
> 768mb(512mb, 256mb) PC133 SDRAM
> Abit KT7A-RAID v1.0(KT133A chipset)
>  Bios 64
>  HPT370(bios v1.2.0604)
>    Primary Master   Quantum Fireball AS40.0
>    Secondary Master IBM-DTLA-307045
>  VIA686B
>    Primary Master   CREATIVE DVD-ROM DVD6240E
>    Secondary Master CR-2801TE
>

