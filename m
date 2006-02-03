Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWBCGEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWBCGEX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 01:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWBCGEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 01:04:23 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:25037
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932144AbWBCGEW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 01:04:22 -0500
Subject: Re: Robust mutexes (-rt)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: David Singleton <daviado@gmail.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <b324b5ad0602021918s45a94b8es5f35618918aa4a7a@mail.gmail.com>
References: <1138740179.5184.34.camel@localhost.localdomain>
	 <b324b5ad0602011528g7ef81dc1ua0ecad2d73348d89@mail.gmail.com>
	 <1138863989.29087.24.camel@localhost.localdomain>
	 <1138909303.29087.51.camel@localhost.localdomain>
	 <b324b5ad0602021918s45a94b8es5f35618918aa4a7a@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 03 Feb 2006 07:04:37 +0100
Message-Id: <1138946677.29087.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.5 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-02 at 19:18 -0800, David Singleton wrote:
> Thomas,
>      here is a patch that fixes the -EINTR problem and a fix for Dinakar's
> simple futex deadlock test program.  When Esben's new deadlock detection
> is ready I plan to use it for robust futex deadlock detection, both simple and
> circular deadlock detection.
> 
> 
>      http://source.mvista.com:~dsingleton/patch-2.6.15-rt16-rf1
> 
>  include/linux/futex.h |    3 +++
>  kernel/futex.c          |    3 +++
>  kernel/rt.c               |   19 ++++++++++++++++++-
>  3 files changed, 24 insertions(+), 1 deletion(-)

The stats are nice. I'd prefer a patch associated with them :)

	tglx


