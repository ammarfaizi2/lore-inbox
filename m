Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277799AbRJIP5K>; Tue, 9 Oct 2001 11:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277798AbRJIP5A>; Tue, 9 Oct 2001 11:57:00 -0400
Received: from sushi.toad.net ([162.33.130.105]:62138 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S277797AbRJIP4y>;
	Tue, 9 Oct 2001 11:56:54 -0400
Subject: Re: sysctl interface to bootflags?
From: Thomas Hood <jdthood@mail.com>
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0110091752150.11249-100000@Appserv.suse.de>
In-Reply-To: <Pine.LNX.4.30.0110091752150.11249-100000@Appserv.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 09 Oct 2001 11:56:53 -0400
Message-Id: <1002643014.1103.42.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jdthood@thanatos:~/src/sbf$ gcc -O2 sbf.c
jdthood@thanatos:~/src/sbf$ su
Password: 
root@thanatos:/home/jdthood/src/sbf# l
./  ../  a.out*  sbf.c
root@thanatos:/home/jdthood/src/sbf# ./a.out
BOOT @ 0x07fd0040
CMOS register:51
Segmentation fault

:(

Thomas

On Tue, 2001-10-09 at 11:52, Dave Jones wrote:
> On 9 Oct 2001, Thomas Hood wrote:
> 
> > jdthood@thanatos:~/src/sbf$ gcc sbf.c
> > Program received signal SIGSEGV, Segmentation fault.
> > 0x80489be in outb_p ()
> 
> outb doesn't work unless you compile with -O2 iirc.
> 
> regards,
> 
> Dave.
> 
> -- 
> | Dave Jones.        http://www.suse.de/~davej
> | SuSE Labs
> 


