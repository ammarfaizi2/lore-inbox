Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274653AbRIYWg5>; Tue, 25 Sep 2001 18:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274655AbRIYWgs>; Tue, 25 Sep 2001 18:36:48 -0400
Received: from freeside.toyota.com ([63.87.74.7]:22020 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S274653AbRIYWgb>; Tue, 25 Sep 2001 18:36:31 -0400
Message-ID: <3BB10700.F1B89F5@lexus.com>
Date: Tue, 25 Sep 2001 15:36:48 -0700
From: J Sloan <jjs@toyota.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Moscatt <pmoscatt@yahoo.com>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Recommended Defaults
In-Reply-To: <20010925215741.47198.qmail@web14704.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Moscatt wrote:

> I am about to compile and install my first kernel and
> want to make sure I have things pretty well set before
> I create the image.
>
> Is there guides available where they show recommended
> defaults - especially in the Network arena ?

1. although the initrd is a nice hack, I generally
avoid all that and compile all the requirements of
the root file system into the kernel -

2. everything else, I generally compile as modular.
this is extremely helpful in troubleshooting, e.g.
you can load/unload drivers without a reboot.

3. It doesn't hurt to have modules compiled for
cards you don't need, since they will not be
loaded. However, you want to avoid the opposite
scenario - not having the driver you need.

4. the defaults are usually sane, but look at
each and every one the first time you do a
kernel config.

5. DO NOT simply blow away your old kernel -
you will be sorry if you do. leave the old kernel
intact as a fallback, and make the necessary
edits to lilo, grub or whatever boot manager
you are using.

Regards,

jjs



