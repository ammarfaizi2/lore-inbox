Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285286AbRL0GQv>; Thu, 27 Dec 2001 01:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285169AbRL0GQl>; Thu, 27 Dec 2001 01:16:41 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:47317 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S285286AbRL0GQ1>; Thu, 27 Dec 2001 01:16:27 -0500
Date: Thu, 27 Dec 2001 08:15:18 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Keith Owens <kaos@ocs.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG and Kernel Panic on 2.5.2-pre1 with loop and cdrom 
In-Reply-To: <11207.1009422284@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.33.0112270814190.28333-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Dec 2001, Keith Owens wrote:

> On Wed, 26 Dec 2001 20:33:07 +0200 (SAST),
> Zwane Mwaikambo <zwane@linux.realnet.co.sz> wrote:
> >eip: cc916780 <== is this because we're in an interrupt handler?
>
> Probably because your module structure after reboot is not the same as
> the panic.  Try using the module data saved in /var/log/ksymoops, man
> insmod and look for ksymoops assistance.

I AM AN IDIOT
come to think of it, loop was built as a module!! argh!

Thanks,
	Zwane Mwaikambo

