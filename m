Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264836AbTBEUbA>; Wed, 5 Feb 2003 15:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264857AbTBEUbA>; Wed, 5 Feb 2003 15:31:00 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:51444 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP
	id <S264836AbTBEUaz>; Wed, 5 Feb 2003 15:30:55 -0500
Date: Thu, 06 Feb 2003 09:41:44 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [ACPI] Re: [PATCH] s4bios for 2.5.59 + apci-20030123
In-reply-to: <20030204221003.GA250@elf.ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Grover, Andrew" <andrew.grover@intel.com>, ducrot@poupinou.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI List <acpi-devel@lists.sourceforge.net>
Message-id: <1044477704.1648.19.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <F760B14C9561B941B89469F59BA3A847137FFE@orsmsx401.jf.intel.com>
 <20030204221003.GA250@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-05 at 11:10, Pavel Machek wrote:
> Some people apparently want slower suspend/resume but have all caches
> intact when resumed. Thats not easy for swsusp but they can have that
> with S4bios. And S4bios is usefull for testing device support; it
> seems to behave slightly differently to S3 meaning better testing.

Whether its slower depends on the hardware; on my 128MB Celeron 933
laptop (17MB/s HDD), I can write an image of about 120MB, reboot and get
back up and running in around a minute and a half. That's about the same
as far as I remember, but has (as you say) the advantage of not still
having to get things swapped back in.

> 
> If you already have hibernation partition from factory, which you are
> using anyway for w98, S4bios is easier to use and more foolproof
> (i.e. you can't boot into wrong kernel which does not resume but does
> fsck instead).

It doesn't really matter what kernel is loaded when we start a resume
anyway, does it? Could they not be different versions because one is
going to replace the other anyway?

Regards,

Nigel


