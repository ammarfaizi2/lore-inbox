Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030437AbWHOSQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030437AbWHOSQv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030439AbWHOSQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:16:51 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:19853 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030437AbWHOSQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:16:50 -0400
Subject: Re: Maximum number of processes in Linux
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Irfan Habib <irfan.habib@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3420082f0608151059s40373a0bg4a1af3618c2b1a05@mail.gmail.com>
References: <3420082f0608151059s40373a0bg4a1af3618c2b1a05@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 15 Aug 2006 19:37:28 +0100
Message-Id: <1155667048.24077.305.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-08-15 am 22:59 +0500, ysgrifennodd Irfan Habib:
> What is the maximum number of process which can run simultaneously in
> linux? I need to create an application which requires 40,000 threads.
> I was testing with far fewer numbers than that, I was getting
> exceptions in pthread_create

On the usual default configuration far less. If you have lots of memory
and adjust the pid limits you can create 40,000 threads. Its not a very
good idea unless you are working on a system with several thousand
processors and usually means your program design is wrong, but you can
do it.

Alan
