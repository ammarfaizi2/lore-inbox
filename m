Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315204AbSF3Ob7>; Sun, 30 Jun 2002 10:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315210AbSF3Ob6>; Sun, 30 Jun 2002 10:31:58 -0400
Received: from [62.70.58.70] ([62.70.58.70]:56965 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S315204AbSF3Ob4> convert rfc822-to-8bit;
	Sun, 30 Jun 2002 10:31:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Francois Romieu <romieu@cogenit.fr>
Subject: Re: Can't boot from /dev/md0 (RAID-1)
Date: Sun, 30 Jun 2002 16:34:23 +0200
User-Agent: KMail/1.4.1
References: <20020630124445.6E95B11979@a.mx.spoiled.org> <200206301602.10599.roy@karlsbakk.net> <20020630162005.A19347@fafner.intra.cogenit.fr>
In-Reply-To: <20020630162005.A19347@fafner.intra.cogenit.fr>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206301634.23800.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What about:
>
> disk=/dev/hda
> bios=0x80
> boot=/dev/hda
>
> map=/boot/map.hda
> install=/boot/boot.b.hda
> backup=/boot/boot.b.rs.hda
>
> prompt
> timeout=50
> linear
>
> image=/boot/bzImage-2.4.19-pre7
>         label=2.4.19-pre7
>         root=/dev/md1
>         read-only

It doesn't work. Still LI only.

Any other ideas

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

