Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277783AbRJIPwu>; Tue, 9 Oct 2001 11:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277788AbRJIPwk>; Tue, 9 Oct 2001 11:52:40 -0400
Received: from ns.suse.de ([213.95.15.193]:6156 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S277783AbRJIPwX>;
	Tue, 9 Oct 2001 11:52:23 -0400
Date: Tue, 9 Oct 2001 17:52:53 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Thomas Hood <jdthood@mail.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: sysctl interface to bootflags?
In-Reply-To: <1002642610.1103.39.camel@thanatos>
Message-ID: <Pine.LNX.4.30.0110091752150.11249-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Oct 2001, Thomas Hood wrote:

> jdthood@thanatos:~/src/sbf$ gcc sbf.c
> Program received signal SIGSEGV, Segmentation fault.
> 0x80489be in outb_p ()

outb doesn't work unless you compile with -O2 iirc.

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

