Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274362AbRJJC5J>; Tue, 9 Oct 2001 22:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274337AbRJJC47>; Tue, 9 Oct 2001 22:56:59 -0400
Received: from sushi.toad.net ([162.33.130.105]:52151 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S274362AbRJJC4m>;
	Tue, 9 Oct 2001 22:56:42 -0400
Subject: Re: sysctl interface to bootflags?
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Cc: davej@suse.de
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 08 Oct 2001 22:56:26 -0400
Message-Id: <1002596188.5283.17.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, it may run, but what it changed was NOT the SBF field.
When I restarted my machine the BIOS beeped and told me
there was an error in the nonvolatile RAM.  I was made to
reset the system date, and then the computer rebooted
normally.

--
Thomas

> Thanks.  I tested the new sbf.c and after hacking it a
> bit to remove the fail-on-invalid-reg-value, it runs:
>
> root@thanatos:/home/jdthood/src/sbf# ./a.out
> BOOT @ 0x07fd0040
> CMOS register: 0x33
> Read current value := 0x88
> Read updated value := 0x89
>
> Here it has set bit 0, the PnP-OS bit.  Do you have any
> plans to enhance the program to allow control of all the flags?




