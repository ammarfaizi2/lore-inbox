Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136161AbRD0Sa0>; Fri, 27 Apr 2001 14:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136165AbRD0SaG>; Fri, 27 Apr 2001 14:30:06 -0400
Received: from www.topmail.de ([212.255.16.226]:35009 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S136161AbRD0S35>;
	Fri, 27 Apr 2001 14:29:57 -0400
Message-ID: <000001c0cf48$0e166ec0$de00a8c0@homeip.net>
From: "mirabilos" <eccesys@topmail.de>
To: "David Woodhouse" <dwmw2@infradead.org>,
        "Padraig Brady" <padraig@antefacto.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <3AE99CE8.BD325F52@antefacto.com>  <Pine.LNX.3.96.1010426203656.22847A-100000@medusa.sparta.lu.se>  <15296.988386995@redhat.com>
Subject: Re: ramdisk/tmpfs/ramfs/memfs ? 
Date: Fri, 27 Apr 2001 16:19:57 -0000
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

> > btw I get my initial root filesystem from a compact flash that can
be
> > accessed just like a hardisk. It's writeable also like a harddisk,
but
> > we boot with it readonly, and only mount it rw if we want to save
> > config or whatever. We definitely wouldn't swap to it as it has
> > limited erase/write cycles. The filesystem is compressed ext2.
>
> Why copy it into RAM? Why not use cramfs and either turn the writable
> directories into symlinks into a ramfs which you create at boot time,
or
> union-mount a ramfs over the top of it?

Hey! SOunds great! How to do it?
I tried to # mount --bind the directories but they do not show
me both entries. I have romfs root and tmpfs.

-mirabilos


