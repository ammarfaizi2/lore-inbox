Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261563AbSJ2LPi>; Tue, 29 Oct 2002 06:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261686AbSJ2LPi>; Tue, 29 Oct 2002 06:15:38 -0500
Received: from [212.3.242.3] ([212.3.242.3]:10742 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id <S261563AbSJ2LPg>;
	Tue, 29 Oct 2002 06:15:36 -0500
Content-Type: text/plain; charset=US-ASCII
From: DevilKin <devilkin-lkml@blindguardian.org>
To: Jos Hulzink <josh@stack.nl>, linux-kernel@vger.kernel.org
Subject: Re: [2.5.44] Poweroff after warm reboot
Date: Tue, 29 Oct 2002 12:21:24 +0100
User-Agent: KMail/1.4.3
References: <200210291031.11837.devilkin-lkml@blindguardian.org> <200210291109.33009.josh@stack.nl>
In-Reply-To: <200210291109.33009.josh@stack.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210291221.24946.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 October 2002 11:09, Jos Hulzink wrote:
> On Tuesday 29 October 2002 10:31, DevilKin wrote:
> > Hello,
> >
> > If I reboot my laptop with kernel 2.5.44 (warm reboot), the machine
> > reboots, loads the kernel, and then in the middle of the booting process
> > powers off.
>
> Hmm... maybe it has something to do with ACPI ? Could you try booting the
> kernel after a warm reboot with ACPI disabled ?

It's APM, not ACPI (luckely :oP)

>
> An other thing I can think about is that a driver does odd things due to
> the fact that the hardware isn't reinitialized completely. See dmesg what
> driver comes after that serial driver and disable the serial driver and /
> or the other driver. See if this helps.

Well, I'd first have to figure out what driver it is, since my screen goes 
entirely blank...

DK
-- 
Darth Vader sleeps with a Teddywookie.

