Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135942AbRD0Lhb>; Fri, 27 Apr 2001 07:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135994AbRD0LhU>; Fri, 27 Apr 2001 07:37:20 -0400
Received: from www.topmail.de ([212.255.16.226]:41697 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S135988AbRD0LhE>;
	Fri, 27 Apr 2001 07:37:04 -0400
Message-ID: <026001c0cf0e$6128f5e0$de00a8c0@homeip.net>
From: "mirabilos" <eccesys@topmail.de>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1010426203656.22847A-100000@medusa.sparta.lu.se>  <21093.988364178@redhat.com>
Subject: Re: ramdisk/tmpfs/ramfs/memfs ? 
Date: Fri, 27 Apr 2001 11:36:05 -0000
Organization: eccesys.net Linux development
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

> >  you could try using jffs2 on a RAM-simulated MTD partition. i think
> > that would work but i have not tried it..
>
> It works. Most of the early testing and development was done on it. It
> wouldn't give you dynamic sizing like ramfs though.
>
> It would be nice to have a version of ramfs which compresses pages
into a
> separate backing store when they're unused. Shame somebody nicked the
name

great... especially for my boot/rootdisks on an 8/16MB system which
start
swapon right in the /linuxrc

> 'cramfs' for something else, really :)

This should be names cromfs as IIRC it isn't writable.

>
> But I'm confused. Padraig, if you have no backing store, where do the
> initial contents of your root filesystem come from?

Netboot? Floppies? (as for me)

-mirabilos


