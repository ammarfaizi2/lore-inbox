Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262352AbUK3WTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbUK3WTc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 17:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262354AbUK3WTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 17:19:32 -0500
Received: from mail.dif.dk ([193.138.115.101]:47295 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262352AbUK3WTa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 17:19:30 -0500
Date: Tue, 30 Nov 2004 23:29:20 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] misleading error message
In-Reply-To: <Pine.LNX.4.53.0411302310080.31695@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.61.0411302328450.3635@dragon.hygekrogen.localhost>
References: <001101c4d715$25a59470$af00a8c0@BEBEL>
 <Pine.LNX.4.61.0411302251180.3635@dragon.hygekrogen.localhost>
 <Pine.LNX.4.53.0411302310080.31695@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2004, Jan Engelhardt wrote:

> >> This may be a BUG REPORT, as I see it, allthough more experienced Linux users
> >> might think differently:
> >>
> >> I compiled built-in support for iptables in my new 2.6.9 kernel, but when my
> >> legacy firewall does a "modprobe ip_tables" , I get the startling message:
> >> "FATAL: module ip_tables not found" .
> >
> >In my oppinion the message is perfectly clear. You told modprobe to load a
> >module, the file was not found so it is forced to give up - and that's
> >exactely what it told you.
> 
> So how would you go about finding out whether something is compiled-in?
> 
Personally I'd just go check my kernels .config

-- 
Jesper Juhl


