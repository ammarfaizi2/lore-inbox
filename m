Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266540AbSLDNGT>; Wed, 4 Dec 2002 08:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266548AbSLDNFu>; Wed, 4 Dec 2002 08:05:50 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:56996 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266546AbSLDNFm>; Wed, 4 Dec 2002 08:05:42 -0500
Subject: Re: testing mouse device driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Shahid <z-shahid@runbox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <00d101c29b8d$63e45e80$4b614ccb@zaman>
References: <00d101c29b8d$63e45e80$4b614ccb@zaman>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Dec 2002 13:47:39 +0000
Message-Id: <1039009659.15359.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Minor 0 is dynamic - you probably want to pick another minor number or
look in /proc/misc to see which minor was chosen.

The PS/2 port is rather special btw and tied in with the keyboard so
isnt one you can treat seperately. Fortunately no PS/2 mouse should need
any 2.4 kernel hacks, just user space stuff to handle different command
streams

