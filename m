Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129550AbRBXJlM>; Sat, 24 Feb 2001 04:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129555AbRBXJlD>; Sat, 24 Feb 2001 04:41:03 -0500
Received: from d14144.upc-d.chello.nl ([213.46.14.144]:13716 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S129550AbRBXJkv>;
	Sat, 24 Feb 2001 04:40:51 -0500
Message-Id: <m14WbC4-000Ob6C@amadeus.home.nl>
Date: Sat, 24 Feb 2001 10:40:48 +0100 (CET)
From: arjan@fenrus.demon.nl (Arjan van de Ven)
To: salimma1@yahoo.co.uk (Michèl Alexandre Salim)
Subject: Re: 2.42 broke PCMCIA IDE
cc: linux-kernel@vger.kernel.org
X-Newsgroups: fenrus.linux.kernel
In-Reply-To: <20010224013821.18282.qmail@web3506.mail.yahoo.com>
User-Agent: tin/pre-1.4-981002 ("Phobia") (UNIX) (Linux/2.2.18pre19 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010224013821.18282.qmail@web3506.mail.yahoo.com> you wrote:

> Kernel boots, and... pcmcia-cs starts with a high and
> low beep. Card detected as a 5V using cardctl status,
> but silly me, forgot to note the reading given by
> cardctl ident.

Make sure your /etc/pcmcia scripts list the driver as "ide-cs" not "ide_cs".
The module is called like that for a while now, and you might have had an
old symlink lying around from 2.4.1

Greetings,
   Arjan van de Ven
