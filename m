Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131309AbRCKHVM>; Sun, 11 Mar 2001 02:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131324AbRCKHVC>; Sun, 11 Mar 2001 02:21:02 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:48145 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131309AbRCKHUo>;
	Sun, 11 Mar 2001 02:20:44 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: David Raufeisen <david@fortyoz.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.3pre1: kernel BUG at page_alloc.c:73! 
In-Reply-To: Your message of "Sat, 10 Mar 2001 23:12:50 -0800."
             <20010310231250.A5391@fortyoz.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 11 Mar 2001 18:19:57 +1100
Message-ID: <15534.984295197@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Suday, 11 March 2001, at 17:54:23 (+1100),
>Keith Owens wrote:
>> Bug caused by binary only driver.  Complain to nvidia, not linux-kernel.
On Sat, 10 Mar 2001 23:12:50 -0800, 
David Raufeisen <david@fortyoz.org> wrote:
>Well, the kernel module is open source..

That is just the glue code that nvidia uses to fool people.  The kernel
module just creates a device that the main nvidia driver abuses to
bypass all the kernel checks.  The real code is a 2M binary only blob.

