Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274681AbRJAHj6>; Mon, 1 Oct 2001 03:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274708AbRJAHjs>; Mon, 1 Oct 2001 03:39:48 -0400
Received: from mail.scs.ch ([212.254.229.5]:35472 "EHLO mail.scs.ch")
	by vger.kernel.org with ESMTP id <S274681AbRJAHji>;
	Mon, 1 Oct 2001 03:39:38 -0400
Message-ID: <3BB81DCD.24D8338F@scs.ch>
Date: Mon, 01 Oct 2001 09:39:57 +0200
From: Martin Maletinsky <maletinsky@scs.ch>
Organization: Supercomputing Systems
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Anil Kumar <kernelmack@yahoo.com>
CC: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: Re: putting a user program to sleep till interrupted
In-Reply-To: <20010928165004.3060.qmail@web20401.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

A good explanation is found in:
http://www.linuxdoc.org/LDP/lki/lki-2.html#ss2.5

and also in Chapter 5, 'Linux Device Drivers' from Alessandro Rubini & Jonathan Corbet
(you find an electronic version of the book in http://www.oreilly.com/catalog/linuxdrive2/)

regards
Martin

Anil Kumar wrote:

> hi,
> I wanted to know how a user program/process can be put
> to sleep by using the functions given in the kernel. I
> will be calling the function not from user space but
> from kernel space, i.e. from inside the kernel. I also
> want to be able to start it again whenever required.
> I went thru sched.c but couldn't figure out how to
> make my own wait list.
> Thanx in advance.
> Anil
>
> __________________________________________________
> Do You Yahoo!?
> Listen to your Yahoo! Mail messages from any phone.
> http://phone.yahoo.com
> -
> Kernelnewbies: Help each other learn about the Linux kernel.
> Archive:       http://mail.nl.linux.org/kernelnewbies/
> IRC Channel:   irc.openprojects.net / #kernelnewbies
> Web Page:      http://www.kernelnewbies.org/

--
Supercomputing System AG          email: maletinsky@scs.ch
Martin Maletinsky                 phone: +41 (0)1 445 16 05
Technoparkstrasse 1               fax:   +41 (0)1 445 16 10
CH-8005 Zurich


