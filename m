Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288191AbSANHl3>; Mon, 14 Jan 2002 02:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288890AbSANHlJ>; Mon, 14 Jan 2002 02:41:09 -0500
Received: from quechua.inka.de ([212.227.14.2]:4211 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S288191AbSANHk7>;
	Mon, 14 Jan 2002 02:40:59 -0500
From: Bernd Eckenfels <ecki-news2002-01@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: strange kernel message when hacking the NIC driver
In-Reply-To: <Pine.LNX.4.33.0201140831240.28735-100000@netfinity.realnet.co.sz>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E16Q1jo-0006Op-00@sites.inka.de>
Date: Mon, 14 Jan 2002 08:41:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0201140831240.28735-100000@netfinity.realnet.co.sz> you wrote:
> Using your argument... Everytime my feline decides to chew my ethernet
> cable i lose my network connection, hence i get ICMP HOST UNREACHABLE ergo
> my cat has very much to do with ARP.

> Those are errors just filtering up the layers, same way an app doesn't
> know anything about what device you're writing to, but will complain about
> incomplete data writes if you run out of space.

Well actually, the neighbour alive discovery done by arp influences the
routing cache very much. Therefore recent Linux networking is actually able to
send "Host unreachable" messages based on the fact, that an host is down.

You are right, that it is not closely related, but it is something one should
not forget, since it is a behaviour introduced in 2.2 kernels, I think.

You can check it with "ip neig". Entries which have an unreachable host are
marked with "nud failed".

Greetings
Bernd
