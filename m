Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289290AbSBDXe4>; Mon, 4 Feb 2002 18:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289293AbSBDXer>; Mon, 4 Feb 2002 18:34:47 -0500
Received: from jalon.able.es ([212.97.163.2]:32693 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S289290AbSBDXeg>;
	Mon, 4 Feb 2002 18:34:36 -0500
Date: Tue, 5 Feb 2002 00:34:13 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Subject: Re: How to check the kernel compile options ?
Message-ID: <20020205003413.G10594@werewolf.able.es>
In-Reply-To: <E16XmqC-0007lb-00@the-village.bc.nu> <3C5EC104.A3412D56@uni-mb.si> <E16Xmjc-0001uS-00@Princess> <E16XnUr-0004mf-00@starship.berlin> <3C5ECF8C.1744549C@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3C5ECF8C.1744549C@redhat.com>; from arjanv@redhat.com on lun, feb 04, 2002 at 19:14:36 +0100
X-Mailer: Balsa 1.3.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20020204 Arjan van de Ven wrote:
>
>> > What he is saying is that you can't do that, generically. Some options are
>> > available at runtime through /proc, but most are not. You need to check what
>> > happend back at compile time.
>> 
>> Right, there is a religious issue here: some core kernel hackers believe
>> that it is wrong to encode kernel configuration in the kernel, and that
>> is why it's not available.  Technically it is not difficult, nor is it
>> difficult to make it memory-efficient.
>
>It's silly to put it permanently in unswappable memory; putting it in 
>/lib/modules/`uname -r/
>somewhere does make tons of sense instead.

Mandrake (and think also redhat) save the kenel config used at
/boot/config-x.y.z-abc

So look for /boot/config-`uname -r`

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.18-pre7-slb #1 SMP Mon Feb 4 21:21:52 CET 2002 i686
