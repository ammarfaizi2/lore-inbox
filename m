Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267105AbSLKKOO>; Wed, 11 Dec 2002 05:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267107AbSLKKOO>; Wed, 11 Dec 2002 05:14:14 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:19462 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S267105AbSLKKOO>; Wed, 11 Dec 2002 05:14:14 -0500
Message-ID: <3DF71090.FB99177C@aitel.hist.no>
Date: Wed, 11 Dec 2002 11:16:48 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.5.51 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: wz6b@arrl.net, linux-kernel@vger.kernel.org
Subject: Re: Expeiment with a simple boot?
References: <200212100954.33462.wz6b@arrl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Young wrote:
> 
> Using 2.5.50 is there a boot procedure such as:
> 
> Turn off DEVFS and INITRDFS then specify the root device with major and minor
> numbers in the linux command line, (using grub)

Sure.  You don't need devfs to boot.  And you don't need any
initrd either, of course.  Just compile the drivers for your root disk
and your root fs into the kernel instead of using modules for them.
I never used an initrd - no need.

I do this with lilo all the time, as I haven't looked at grub.

Helge Hafting
