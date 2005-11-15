Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932494AbVKOOOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbVKOOOI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 09:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbVKOOOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 09:14:08 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:21135 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932494AbVKOOOH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 09:14:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b1/faviVD1TTV+KVBKB74X0PzYgaOrOiUjchM2cfibey33/dWWhvgvhaZQH0FDZXCkWNB2KcMgkMFzojtrVzv029fiZKkWwteLllBvya5Mo8kPV9S3QXh6FQYYrtYFsU1Li/frRwipoEZPekqHZ9nRY/oYwh2p9P6Fw/nw+En5o=
Message-ID: <2cd57c900511150614p27943135r@mail.gmail.com>
Date: Tue, 15 Nov 2005 22:14:04 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Linux Kernel ml <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.6.15-rc1 crashed my file system for 2.6.14
In-Reply-To: <20051115135526.GA24374@tik.ee.ethz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051115135526.GA24374@tik.ee.ethz.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/11/15, Lukas Ruf <ruf@rawip.org>:
> Dear all,
>
> today, I tried linux-2.6.15-rc1 on my laptop (thinkpad t40p).
> Before it had been running 2.6.14 without troubles.
>
> What happened:
>
> - compiled 2.6.15-rc1 with the 2.6.14 .config file.
>
> - make install modules_install ; update-grub
>
> - booted into 2.6.15-rc1
>
> - started X.org (latest available in Debian unstable, DNR version)
>
> - crashed the screen output -> rebooted
>
> - booted in 2.6.14 (that run without problems)
>
> - received the 'VFS ... cannot mount root ...' error message

What's the detalls here? screen shots maybe.

>   (ext2 and ext3 are statically compiled into the kernel)
>
> - booted into Knoppix, fsck.ext3 didn't show any error
>
> - retried 2.6.14 -- same error persists
>
> - 2.6.15-rc1 boots still smoothly
>
> - however, 2.6.15-rc1 has still no screen output after trying to
>   start X.

what does /var/log/Xorg.0.log show?

>
> ---> how can I get back to 2.6.14 without loosing data
>
> Any help is very welcome and urgently needed.
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
