Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262649AbTJ3Qx3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 11:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbTJ3Qx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 11:53:29 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2432 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262649AbTJ3Qx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 11:53:28 -0500
Date: Thu, 30 Oct 2003 16:55:45 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200310301655.h9UGtjn5000166@81-2-122-30.bradfords.org.uk>
To: Dave Jones <davej@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
In-Reply-To: <20031030151831.GA11311@redhat.com>
References: <20031030141519.GA10700@redhat.com>
 <3FA128C4.5040502@pobox.com>
 <20031030151831.GA11311@redhat.com>
Subject: Re: Post-halloween doc updates.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > >Compiler issues.
>  > >~~~~~~~~~~~~~~~~
>  > >- The recommended compiler (for x86) is still 2.95.3.
>  > 
>  > I'm not sure this is still the case, in practice.  Recent times have 
>  > seen people breaking 2.95.x, which did not support the C99/C++ style of 
>  > mixing variable declarations and code.  People would forget this, and we 
>  > only find out a few days later that the 2.95.x build was broken.
> 
> *nod*, more and more distros are now shipping gcc3 as their stock compiler,

That may be partially motivated by the fact that latest GLIBC no
longer compiles with GCC 2.95.x

> so it's likely at some point things are going to change.

Do you think that GCC > 2.95.x actually produces noticably better code
though?  I'm not convinced yet, and yet compile times can be a lot
higher.

By the way, it might be worth adding something to the input devices
section suggesting that people try forcing set 3 if they have a
keyboard which has keys that are not independently usable, and it's
not a regression since 2.4.  I have such a keyboard, and I saw a post
recently describing similar behavior with a VMS keyboard.

John.
