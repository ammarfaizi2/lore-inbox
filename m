Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318044AbSGWMeU>; Tue, 23 Jul 2002 08:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318015AbSGWMeT>; Tue, 23 Jul 2002 08:34:19 -0400
Received: from ep09.kernel.pl ([212.87.11.162]:8365 "EHLO ep09.kernel.pl")
	by vger.kernel.org with ESMTP id <S318044AbSGWMeT>;
	Tue, 23 Jul 2002 08:34:19 -0400
Message-ID: <018c01c23245$c8434820$0201a8c0@witek>
From: "Witek Krecicki" <adasi@kernel.pl>
To: "Jose Luis Domingo Lopez" <linux-kernel@24x7linux.org>,
       "Linux-Kernel" <linux-kernel@vger.kernel.org>
References: <20020723091438.GB3455@localhost>
Subject: Re: [Build Errors] kernel version 2.5.27
Date: Tue, 23 Jul 2002 14:37:57 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Jose Luis Domingo Lopez" <linux-kernel@24x7linux.org>
> Hi:
>
> Don't know if this can be helpful at all, but having a "powerful" (AMD XP
> 1700+, 256 MB DDR and 7200 rpm IDE disk) PC doing nothing most of the
> time, I thought it could be doing something useful for the ongoing
> development of the linux kernel. So I decided to do a full kernel compile
> (that is, a compile of the linux kernel with _all_ options enabled to be
> compiled built-in, just a few as modules, those that can't be built
> otherwise). And report errors that can happen, in the hope to unveil
> them and make maintainers aware of them, should they still aren't.
>
> .config file was created the "easy" way: going to all options shown in a
> "make menuconfig" session, enabling everything to be built-in (when
> possible), and making a second pass to check if some options were
> activated by enabling some others. The file is 2206 lines long, but is
> NOT attached, to help save bandwidth.
IMHO building everything as a module is much better in this case. Some
things are working built-in but not working as modules (eg.
probably-still-not-fixed 2.5 IDE with 2 symbols not exported properly). It
would be better to build everything as a module and then check it with
depmod so any unresolved deps could be shown
WK


