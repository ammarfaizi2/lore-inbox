Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272467AbRIRQUN>; Tue, 18 Sep 2001 12:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272493AbRIRQUD>; Tue, 18 Sep 2001 12:20:03 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:20499 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S272467AbRIRQTt>;
	Tue, 18 Sep 2001 12:19:49 -0400
Date: Tue, 18 Sep 2001 18:20:11 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Knut.Neumann@rz.uni-duesseldorf.de
Subject: Re: SonyPI Driver
Message-ID: <20010918182011.G14639@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I noticed that when running the sonypi driver on my VAIO z600tek, APM Suspend
> does no longer work: The power button (to suspend) does no longer work and -
> well - it will still suspend if I force it to, by apm -s but it does not
> resume (powers on, but blank screen and no input gets processed).

Yep, using the sonypi driver switches the laptop in a pseudo acpi
mode and APM based suspend will get disabled.

This is a known problem and there is currently no workaround
(especially since on my Vaio - a C1VE model, even the APM suspend
hangs).

You'll have to wait for ACPI suspend support in the kernel
(some support will get into the 2.5 kernel series) or choose between
the sonypi driver and APM suspend.

Of course, you can always find a workaround, in which case I and many
other Vaio owners will be grateful to you :-).

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
