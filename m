Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315200AbSF3NCI>; Sun, 30 Jun 2002 09:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315202AbSF3NCH>; Sun, 30 Jun 2002 09:02:07 -0400
Received: from [62.70.58.70] ([62.70.58.70]:53637 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S315200AbSF3NCH> convert rfc822-to-8bit;
	Sun, 30 Jun 2002 09:02:07 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Juri Haberland <juri@koschikode.com>
Subject: Re: Can't boot from /dev/md0 (RAID-1)
Date: Sun, 30 Jun 2002 15:04:35 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <20020630124445.6E95B11979@a.mx.spoiled.org> <200206301449.51190.roy@karlsbakk.net> <3D1EFF5C.6010405@koschikode.com>
In-Reply-To: <3D1EFF5C.6010405@koschikode.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206301504.35221.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hm, I'm no lilo nor raid expert, but I'd suggest to strip down the
> lilo.conf to the defaults. E.g. I have:
> prompt
> timeout=50
> default=linux
> boot=/dev/md2
> map=/boot/map
> install=/boot/boot.b
> message=/boot/message
>
> image=/boot/vmlinuz
>         label=linux
>         read-only
>         root=/dev/md0

hm...
still gave me 'LI'
I beleive it might be because LILO need to be installed on the first drive 
BIOS finds (/dev/hdm). I might try to address it as 0x80? Do you think 
that'll help?

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

