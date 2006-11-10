Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932830AbWKJK2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932830AbWKJK2M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 05:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932635AbWKJK2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 05:28:12 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:29406 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932830AbWKJK2L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 05:28:11 -0500
Subject: Re: Strange write errors on FAT32 partition (maybe an FAT32 bug?!)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Anton Mitterer <calestyo@scientia.net>
Cc: Roger Heflin <rheflin@atipa.com>, linux-kernel@vger.kernel.org
In-Reply-To: <4553A6C9.4010906@scientia.net>
References: <4550A481.2010408@scientia.net>
	 <87psbzrss2.fsf@duaron.myhome.or.jp> <4553744E.3050007@scientia.net>
	 <45539188.5080607@atipa.com> <45539366.7070809@scientia.net>
	 <45539588.7020504@atipa.com> <45539699.40105@scientia.net>
	 <45539753.7060906@atipa.com> <4553A461.4080002@scientia.net>
	 <4553A57C.5070503@atipa.com>  <4553A6C9.4010906@scientia.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 10 Nov 2006 10:28:55 +0000
Message-Id: <1163154536.7900.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-11-09 am 23:08 +0100, ysgrifennodd Christoph Anton
Mitterer:
> And I've already had diff errors again,..
> so if there had been some parity issue it should have been logged, right?

If it was a PCI side parity error yes. If you have dodgy memory then the
K8 will MCE and report that if the MCE code is loaded. If the memory is
non ECC or the CPU doesn't support ECC memory you'll get silent strange
behaviour, but a long run of memtest86 can usually find any main memory
problems.

Alan

