Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282276AbRLHQ4Q>; Sat, 8 Dec 2001 11:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282300AbRLHQ4G>; Sat, 8 Dec 2001 11:56:06 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:18963 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S282276AbRLHQz5>; Sat, 8 Dec 2001 11:55:57 -0500
Date: Sat, 8 Dec 2001 17:55:44 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Lee Packham <lpackham@mswinxp.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Support of sonypi module/code
Message-ID: <20011208175544.A22574@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <000001c17fc3$fe666c00$0102a8c0@lee>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <000001c17fc3$fe666c00$0102a8c0@lee>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08, 2001 at 08:40:30AM -0000, Lee Packham wrote:

> Am I going to be treading on anybody's toes if I release a patch for the
> sonypi module to add battery and AC power information support?

Mines. The driver _is_ maintained.

> The reason is thus, to stop the fan spinning all the time on my laptop I
> have to use ACPI (I have a Vaio FX-103). It doesn't work great, but it
> works...
> 
> ACPI can't report battery info. Nor can APM!

The latest versions of ACPI work pretty well, if it doesn't work
for you it must be because of buggy ACPI bios. At least in my case,
I found out that flashing a newer bios (look out for bioses that
support Windows XP on the sony site) solves most of the problems.

> You have to use the Programmable Interrupts thing to get them out of the
> system. I wrote a program that did this (vaiod) on a polling interval to
> set my screen brightness automagically but I would have to poll things
> manually. It would be great to do this though /dev/sonypi.

Why not. We already do this with ioctls for brightness control.

> It doesn't look like the code has been updated for ages. So is anybody
> going to complain if I do it?

Your significance of 'ages' must be different that mines... 

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
