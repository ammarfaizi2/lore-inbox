Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292385AbSBUOKg>; Thu, 21 Feb 2002 09:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292387AbSBUOK0>; Thu, 21 Feb 2002 09:10:26 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:10698 "EHLO xfe3.d.ethz.ch")
	by vger.kernel.org with ESMTP id <S292385AbSBUOKL>;
	Thu, 21 Feb 2002 09:10:11 -0500
Message-ID: <3C74FF03.8070502@debian.org>
Date: Thu, 21 Feb 2002 15:06:59 +0100
From: Giacomo Catenazzi <cate@debian.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: andersen@codepoet.org, Roman Zippel <zippel@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: Re: linux kernel config converter
In-Reply-To: <fa.fsgrt4v.1bngh9t@ifi.uio.no> <fa.hp69onv.i7qtq3@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Feb 2002 14:10:09.0810 (UTC) FILETIME=[78AD0F20:01C1BAE1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jeff Garzik wrote:

> Erik Andersen wrote:
> 
>>I like this.  It's simple, its clean, and it keeps all the
>>information in one spot.  I think we can go a bit farther here
>>and add in a list of the .c files that enabling this feature
>>should add to the Makefile (per the current
>>    obj-$(CONFIG_FOO)            += foo.o
>>stuff in the current Makefile).
> 
> Seriously, yep, that's exactly where we eventually want to be:  all
> config, makefile, and help text info in one place.  To add a new net
> driver, I want to be able to simply add two files, driver.c and
> driver.conf, and be done with it.


with kbuild-2.5 this can be done easy. We should maintain
the syntax of kbuild-2.5 (or a subset).

But the makefile/makefile.in will remain: not all code
in kernel is drivers, and for the non drivers makefile/config.in
IMHO it is better to have 'central' (per directory/per type)
config and makefile files.

 
	giacomo


