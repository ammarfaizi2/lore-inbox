Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261693AbSIXPZc>; Tue, 24 Sep 2002 11:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261694AbSIXPZc>; Tue, 24 Sep 2002 11:25:32 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:50608 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S261693AbSIXPZc>; Tue, 24 Sep 2002 11:25:32 -0400
Date: Tue, 24 Sep 2002 11:30:37 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: UP IO-APIC
In-Reply-To: <Pine.LNX.4.44.0209240331280.20792-100000@montezuma.mastecende.com>
Message-ID: <Pine.GSO.4.33.0209241119500.11624-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Sep 2002, Zwane Mwaikambo wrote:
>> Would someone kindly remove that from the configuration possibilities?  It
>> doesn't work -- and hasn't worked for, what, a year.
>
>Worked for me on 2.4.19-pre and 2.5 (haven't tried recent), and still
>thats a bad reason to remove it.

It works in 2.4, but I've never seen it work in 2.5 -- but I've not compiled
every 2.5.X.  Neither the local APIC or IO APIC work in non-SMP configurations
due to dependencies on things in mpparse.c (read: SMP functions.)  The local
APIC makes perfect sense albeit rare.  Single processor IO APICs are very
rare and are usually MP systems with only one processor.

APIC support in 2.5 is very closely tied to SMP. (and technically, ACPI.)

--Ricky


