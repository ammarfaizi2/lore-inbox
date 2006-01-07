Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030467AbWAGWfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030467AbWAGWfU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 17:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752593AbWAGWfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 17:35:19 -0500
Received: from quechua.inka.de ([193.197.184.2]:35264 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1752591AbWAGWfT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 17:35:19 -0500
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: Almost 80% of UDP packets dropped
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <200601071704.52833.vda@ilport.com.ua>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1EvMeb-0005w4-00@calista.inka.de>
Date: Sat, 07 Jan 2006 23:35:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@ilport.com.ua> wrote:
> UDP is connectionless. There is no way for sender to know that it must
> stop sending UDP packets because receiver cannot keep up. If sender
> and your network is producing and delivering UDP packets faster
> than receiver can consume them, packets will be lost.

Yes, but the problem of the OP sounds like the interrupt handling on mips
pretty badly affects the scheduler. I guess softwareinterrupts and network
polling would help here.

Gruss
Bernd
