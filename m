Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315120AbSF3Mr2>; Sun, 30 Jun 2002 08:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315162AbSF3Mr1>; Sun, 30 Jun 2002 08:47:27 -0400
Received: from [62.70.58.70] ([62.70.58.70]:52869 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S315120AbSF3Mr1> convert rfc822-to-8bit;
	Sun, 30 Jun 2002 08:47:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Juri Haberland <juri@koschikode.com>
Subject: Re: Can't boot from /dev/md0 (RAID-1)
Date: Sun, 30 Jun 2002 14:49:51 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <20020630124445.6E95B11979@a.mx.spoiled.org>
In-Reply-To: <20020630124445.6E95B11979@a.mx.spoiled.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206301449.51190.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> I had this once and resolved it with adding a "default" line to the
> lilo.conf:
> default = LinuxRaid
>
> Also have boot=/dev/md0, not boot=/dev/hda.

hm

I keep getting this one..

[root@jumbo root]# lilo
boot = /dev/hda, map = /boot/map.0301
Added linux2419rc1 *
Added linux2418
Added linux-orig
Fatal: Duplicate geometry definition for /dev/md0

Any ideas?

thanks

roy

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

