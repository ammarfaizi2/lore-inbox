Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262364AbUK3WaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262364AbUK3WaS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 17:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbUK3WaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 17:30:18 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:51114 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262364AbUK3WaL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 17:30:11 -0500
Date: Tue, 30 Nov 2004 23:30:09 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] misleading error message
In-Reply-To: <Pine.LNX.4.61.0411302328450.3635@dragon.hygekrogen.localhost>
Message-ID: <Pine.LNX.4.53.0411302329550.13758@yvahk01.tjqt.qr>
References: <001101c4d715$25a59470$af00a8c0@BEBEL>
 <Pine.LNX.4.61.0411302251180.3635@dragon.hygekrogen.localhost>
 <Pine.LNX.4.53.0411302310080.31695@yvahk01.tjqt.qr>
 <Pine.LNX.4.61.0411302328450.3635@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >> I compiled built-in support for iptables in my new 2.6.9 kernel, but when my
>> >> legacy firewall does a "modprobe ip_tables" , I get the startling message:
>> >> "FATAL: module ip_tables not found" .
>> >
>> >In my oppinion the message is perfectly clear. You told modprobe to load a
>> >module, the file was not found so it is forced to give up - and that's
>> >exactely what it told you.
>>
>> So how would you go about finding out whether something is compiled-in?
>>
>Personally I'd just go check my kernels .config

Please, think of the newbies (tm)


