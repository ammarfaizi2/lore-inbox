Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129110AbQJ3Mzr>; Mon, 30 Oct 2000 07:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129161AbQJ3Mzi>; Mon, 30 Oct 2000 07:55:38 -0500
Received: from [195.63.194.11] ([195.63.194.11]:45575 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S129110AbQJ3Mz1>; Mon, 30 Oct 2000 07:55:27 -0500
Message-ID: <39FD7C4F.74D8DCCC@evision-ventures.com>
Date: Mon, 30 Oct 2000 14:49:03 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.16-1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Samuelson <peter@cadcamlab.org>
CC: Linux Kernel Developer <linux_developer@hotmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Recommended compiler? - Re: [patch] kernel/module.c (plus gratuitous 
 rant)
In-Reply-To: <4309.972694843@ocs3.ocs-net> <20001029232347.D4EB081F9@halfway.linuxcare.com.au> <20001030050821.B9175@wire.cadcamlab.org> <OE43voFOAmEaJswFCHO000004ac@hotmail.com> <20001030055859.C9175@wire.cadcamlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson wrote:
> 
> > So which is the recommended compiler for each kernel version 2.2.x,
> > 2.4.x(pre?) nowadays?
> 
> * 2.91.66 aka egcs 1.1.2.  It has been officially blessed for 2.4 and
>   has been given an informal thumbs-up by Alan for 2.2.  (It does NOT
>   work for 2.0, if you still care about that.)
> 
> * 2.7.2.3 works for 2.2 (and 2.0) but NOT for 2.4.
> 
> * 2.95.2 seems to work with both 2.2 and 2.4 (no known bugs, AFAIK) and
>   many of us use it, but it is a little riskier than egcs.
> 
> * Red Hat "2.96" or CVS 2.97 will probably break any known kernel.

Works fine for me and 2.4.0-test10-pre5... however there are tons of
preprocessor warnings in some drivers.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
