Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266488AbRHOV3S>; Wed, 15 Aug 2001 17:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265402AbRHOV3H>; Wed, 15 Aug 2001 17:29:07 -0400
Received: from fenrus.demon.co.uk ([158.152.228.152]:12980 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S264669AbRHOV2u>;
	Wed, 15 Aug 2001 17:28:50 -0400
Message-Id: <m15X8Dk-000PX7C@amadeus.home.nl>
Date: Wed, 15 Aug 2001 22:29:00 +0100 (BST)
From: arjan@fenrus.demon.nl
To: linux-kernel@vger.kernel.org
Subject: Re: Dell I8000, 2.4.8-ac5 and APM
In-Reply-To: <29219.997909757@redhat.com>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <29219.997909757@redhat.com> you wrote:

> I've been chasing down APM problems on an I8000 today too - the Red Hat 7.2
> beta kernel (which is based on some 2.4-ac) dies on resume, while a clean
> 2.4.9-pre4 survives. I'd noticed that the Red Hat kernel was using the local
> APIC just before giving up on it for the day - turning that off will be the
> first thing I try in the morning.

> Apart from the hang on applying or removing power, were you also having 
> this problem with APM suspend?

> Strangely, APM suspend was working after a suspend-to-disk. It only failed 
> after a clean boot.

Not so strange as suspend to disk most likely disables the apic and
"forgets" to restore it.... that's actually a bios bug (?) helping you out
here....
