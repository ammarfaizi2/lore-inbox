Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275813AbRJJOF2>; Wed, 10 Oct 2001 10:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275816AbRJJOFS>; Wed, 10 Oct 2001 10:05:18 -0400
Received: from ns.suse.de ([213.95.15.193]:26119 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S275813AbRJJOFF>;
	Wed, 10 Oct 2001 10:05:05 -0400
Date: Wed, 10 Oct 2001 16:05:32 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Thomas Hood <jdthood@mail.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: sysctl interface to bootflags?
In-Reply-To: <1002667739.763.9.camel@thanatos>
Message-ID: <Pine.LNX.4.30.0110101603430.26743-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Oct 2001, Thomas Hood wrote:

> Read current value := 0x88
> Read updated value := 0x89
> Here it has set bit 0, the PnP-OS bit.  Do you have any
> plans to enhance the program to allow control of all the flags?

Could be a useful addition, if only during debugging.
The idea iirc is that kernel should put it into a state
where userspace only needs to clear the 'successful boot' flag.
By the time we get to userspace, the parity should be correct also,
so you shouldn't need to hack sbf.c to chop that test out.


regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

