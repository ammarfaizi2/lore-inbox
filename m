Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291224AbSBHAhj>; Thu, 7 Feb 2002 19:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291248AbSBHAh3>; Thu, 7 Feb 2002 19:37:29 -0500
Received: from jalon.able.es ([212.97.163.2]:3277 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S291224AbSBHAhO>;
	Thu, 7 Feb 2002 19:37:14 -0500
Date: Fri, 8 Feb 2002 01:37:05 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Justin Piszcz <war@starband.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Information & Install Kernel Script
Message-ID: <20020208013705.A21496@werewolf.able.es>
In-Reply-To: <3C6267B7.30A3020D@starband.net> <a3ut0u$f60$1@cesium.transmeta.com> <3C62FB81.E053B660@starband.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3C62FB81.E053B660@starband.net>; from war@starband.net on jue, feb 07, 2002 at 23:11:13 +0100
X-Mailer: Balsa 1.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20020207 Justin Piszcz wrote:
>Perhaps, however I began ik in December 2000.
>No /sbin/installkernel existed at the time.
>And /sbin/installkernel doesn't support grub on my rh72 box.
>Nor does it check dependencies, etc, etc.
>

You should really take a look at /sbin/installkernel from Mandrake.
Bootloader autodetection (lilo-grub), old kernel backup, adds entries in
loader config file... a bunch of features. Do not reinvent
the whell.

Perhaps it is time for RedHat to turn heads towards Mandrake.


>"H. Peter Anvin" wrote:
>
>> Followup to:  <3C6267B7.30A3020D@starband.net>
>> By author:    Justin Piszcz <war@starband.net>
>> In newsgroup: linux.dev.kernel
>> >
>> > New site: http://www.installkernel.com/
>> > It is very light at the moment.
>> >
>> > 1] Latest news about the kernel:
>> >    http://www.installkernel.com/kernel.html
>> >    Anything else I should add under 2.4.17?
>> >
>> > 2] Install Kernel (bash script which I am working on)
>> >     http://www.installkernel.com/ik/index.html
>> >     ik-0.8.9: Adds -b option, you can build and install the kernel from
>> > the current directory with -b.
>> >     Summary of ik:
>> >     Install Kernel (ik) is a bash script that installs the Linux kernel
>> > and automatically sets up LILO or GRUB.
>> >     It also saves your kernel configuration each time you do an install.
>> > This allows you to restore the newest
>> >     configuration file when you make a new kernel. This script is
>> > intended for two groups of people; people
>> >     new to compiling kernels, and people who are tired of moving files
>> > around and editing their bootloader
>> >     configurations every time they install a new kernel.
>> >
>>
>> Sounds like you should make this work as /sbin/installkernel.
>>
>>         -hpa
>> --
>> <hpa@transmeta.com> at work, <hpa@zytor.com> in private!
>> "Unix gives you enough rope to shoot yourself in the foot."
>> http://www.zytor.com/~hpa/puzzle.txt    <amsp@zytor.com>
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.18-pre8-slb #1 SMP Tue Feb 5 01:43:29 CET 2002 i686
