Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbTDHP7h (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 11:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbTDHP7h (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 11:59:37 -0400
Received: from chaos.analogic.com ([204.178.40.224]:42628 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261706AbTDHP7e (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 11:59:34 -0400
Date: Tue, 8 Apr 2003 12:13:30 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Jared Young <headgeek@li.nu-x.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Help!!! Pthread Sh*T
In-Reply-To: <20030408123417.5485ba9e.headgeek@li.nu-x.net>
Message-ID: <Pine.LNX.4.53.0304081209110.24014@chaos>
References: <20030408123417.5485ba9e.headgeek@li.nu-x.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Apr 2003, Jared Young wrote:

> I installed pthread libaries recently, anyhow, I keep getting errors what I cannot work around with gcc and make in general. I cannot even compile a new gcc to allow for the new pthread extenstion. I uninstalled pthread libs in hopes to restore prior state but umm yah. After reinstalling::
>
> Current Kernel:2.4.20
> Current GCC:2.95.3
> Current Pthread:1.4.1
>
> This was the error I got when building commoncpp-2-1.0.9, but this error is similar in everything else I try to build.
>
> ::Configure options::::
> ./configure  --prefix=/usr --sysconfdir=/etc --with-pthread --with-ftp
>

You need to reinstall your header files either from backups or from
your distribution. Just overwrite /usr/include/... on down and it will
fix it. Lucky you didn't overwrite libraries ;) That would require
starting from scratch.

In the future, you need to build pthreads into/at-the-same-time as
you build a 'C' runtime library. They then get installed together to
keep them compatible.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

