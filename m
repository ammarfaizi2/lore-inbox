Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315630AbSGANgn>; Mon, 1 Jul 2002 09:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315720AbSGANgm>; Mon, 1 Jul 2002 09:36:42 -0400
Received: from [62.70.58.70] ([62.70.58.70]:1927 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S315630AbSGANgl> convert rfc822-to-8bit;
	Mon, 1 Jul 2002 09:36:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Jakob Oestergaard <jakob@unthought.net>
Subject: Re: Can't boot from /dev/md0 (RAID-1)
Date: Mon, 1 Jul 2002 15:38:55 +0200
User-Agent: KMail/1.4.1
Cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
       linux-raid@vger.rutgers.edu,
       Kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0206301152150.1582-100000@twinlark.arctic.org> <200207011330.18973.roy@karlsbakk.net> <20020701115230.GD18580@unthought.net>
In-Reply-To: <20020701115230.GD18580@unthought.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207011538.55028.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Perhaps you could change the lba32 option into linear ?  I'm really
> shooting in the mist here - LILO tends to "just work", and ignorance is
> bliss   ;)

It still won't work. It doesn't seem to like boot=/dev/md0. see below

roy

[root@jumbo root]# lilo
Warning:  LINEAR is deprecated in favor of LBA32:  LINEAR specifies 24-bit
  disk addresses below the 1024 cylinder limit; LBA32 specifies 32-bit disk
  addresses not subject to cylinder limits on systems with EDD bios 
extensions;
  use LINEAR only if you are aware of its limitations.
Warning: using BIOS device code 0x80 for RAID boot blocks
Fatal: Filesystem would be destroyed by LILO boot sector: /dev/md0
[root@jumbo root]# 


-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

