Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262142AbULCKf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbULCKf3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 05:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262146AbULCKf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 05:35:29 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:64969 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262142AbULCKfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 05:35:24 -0500
Date: Fri, 3 Dec 2004 11:35:21 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] misleading error message
In-Reply-To: <Pine.LNX.4.58.0412022327200.1411@ppg_penguin.kenmoffat.uklinux.net>
Message-ID: <Pine.LNX.4.53.0412031134060.32282@yvahk01.tjqt.qr>
References: <001101c4d715$25a59470$af00a8c0@BEBEL>
 <Pine.LNX.4.61.0411302251180.3635@dragon.hygekrogen.localhost>
 <Pine.LNX.4.53.0411302310080.31695@yvahk01.tjqt.qr>
 <Pine.LNX.4.61.0411302328450.3635@dragon.hygekrogen.localhost>
 <Pine.LNX.4.53.0411302329550.13758@yvahk01.tjqt.qr> <41AF0BA5.5080901@blue-labs.org>
 <Pine.LNX.4.58.0412022327200.1411@ppg_penguin.kenmoffat.uklinux.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Random side thoughts..
>>
>> a) is there a simple way to search for symbols in a running kernel's
>> memory area that
>> b) can differentiate between module and static, and if so
>> c) is there an interest in a tiny tool that scripts  could use to
>> determine existing support?
>>
>
> Take a look in /proc/kallsyms when you have a module loaded. [...]
>grep '\[natsemi\]' /proc/kallsyms

Most distributors do not have the CONFIG_KALLSYMS (or whatever it is called)
active. And IIRC, the help texts say that it consumes a lot of memory (which is
probably due to kallsyms storing not only symbols we need).


Jan Engelhardt
-- 
ENOSPC
