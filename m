Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271818AbRIMQAR>; Thu, 13 Sep 2001 12:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271821AbRIMQAG>; Thu, 13 Sep 2001 12:00:06 -0400
Received: from babel.spoiled.org ([212.84.234.227]:18008 "HELO
	babel.spoiled.org") by vger.kernel.org with SMTP id <S271818AbRIMP7t>;
	Thu, 13 Sep 2001 11:59:49 -0400
Date: 13 Sep 2001 16:00:11 -0000
Message-ID: <20010913160011.939.qmail@babel.spoiled.org>
From: Juri Haberland <juri@koschikode.com>
To: o.zaplinski@mediascape.de (Olaf Zaplinski)
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.19 and eepro100
X-Newsgroups: spoiled.linux.kernel
In-Reply-To: <3BA0C88D.6B170BD5@mediascape.de>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (OpenBSD/2.9 (i386))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3BA0C88D.6B170BD5@mediascape.de> you wrote:
> Hi,
> 
> I got the 2.2.19 sorces, patched them with reiserfs, compiled and booted the
> new kernel. Neither the builtin eepro100 nor Intels e100-1.6.13 driver
> worked; they were loaded, but ifconfig failed:
> 
> + ifconfig eth1 192.168.0.235 broadcast 192.168.0.255 netmask 255.255.255.0
> up
> SIOCSIFFLAGS: Resource temporarily unavailable
> SIOCSIFFLAGS: Resource temporarily unavailable
> 
> What's wrong here? I want 2.2 because 2.4 eats up too much memory on my
> machine, and I have only 256 MB... ;-)

Have a look into the BIOS setup and check whether it is configured for
a non-plug'n'play OS. If not - do so.

Juri

-- 
Juri Haberland  <juri@koschikode.com> 

