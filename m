Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266256AbRF3Tdb>; Sat, 30 Jun 2001 15:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266258AbRF3TdV>; Sat, 30 Jun 2001 15:33:21 -0400
Received: from hssx-sktn-167-47.sasknet.sk.ca ([142.165.167.47]:18181 "HELO
	mail.thock.com") by vger.kernel.org with SMTP id <S266257AbRF3TdO>;
	Sat, 30 Jun 2001 15:33:14 -0400
Message-ID: <3B3E29B0.8B9AB310@bigfoot.com>
Date: Sat, 30 Jun 2001 13:34:08 -0600
From: Dylan Griffiths <Dylan_G@bigfoot.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: EEPro100 problems in SMP on 2.4.5 ?
In-Reply-To: <3B3D4A96.A81A13AD@bigfoot.com> <3B3D61D3.CEDACC4D@uow.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 1: Include `magic sysrq' support in the kernel and use ALT-SYSRQ-T and S
>    when it has locked up.   If you get some traces then please feed them
>    into `ksymoops -m System.map' and report back.

That was locked as well, AFAIK.
 
> 2: If the above doesn't work, add `nmi_watchdog=1' to the kernel boot
>    options.  That may catch the lockup.
> 
> 3: Replace the NIC with another eepro100.  If the problem goes away then
>    chuck the old one.
> 
> 4: Replace the NIC with one of a different type (ie: swap with the other
>    machine). If that fixes it we look at the ethernet driver.  Otherwise
>    we look at, umm, the rest of the kernel.

I'd love to do some of this, but since the box is now being shipped to a
colo facility in New York, I don't really have a choice in the matter.

Hopefully someone here doing SMP + EEPro100 can see if they can reproduce
the issue (2.4.5 kernel).

--
    www.kuro5hin.org -- technology and culture, from the trenches.
