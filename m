Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030480AbWHRQjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030480AbWHRQjp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 12:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030501AbWHRQjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 12:39:45 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52925 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030480AbWHRQjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 12:39:44 -0400
Subject: Re: 2.6.18-rc4-mm1 + hotfix -- Many processes use the sysctl
	system call
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Mattia Dongili <malattia@linux.it>, Miles Lane <miles.lane@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, "akpm@osdl.org" <akpm@osdl.org>
In-Reply-To: <1155918234.24907.35.camel@mindpipe>
References: <a44ae5cd0608171541tf2f125dl586f56da6f1b2a41@mail.gmail.com>
	 <1155854702.8796.97.camel@mindpipe>
	 <20060818144626.GA8236@inferi.kami.home>
	 <1155918234.24907.35.camel@mindpipe>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 18 Aug 2006 18:00:32 +0100
Message-Id: <1155920432.30279.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-08-18 am 12:23 -0400, ysgrifennodd Lee Revell:
> "fixed"?  Why is sysctl being removed in the middle of a stable kernel
> series?!?  I thought the new golden rule was "don't break userspace"?

Its being made optional like a lot of other things. It does probably
belong under CONFIG_EMBEDDED to turn it off tho


Alan

