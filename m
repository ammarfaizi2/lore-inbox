Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315884AbSEQMmc>; Fri, 17 May 2002 08:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315981AbSEQMmb>; Fri, 17 May 2002 08:42:31 -0400
Received: from loewe.cosy.sbg.ac.at ([141.201.2.12]:64128 "EHLO
	loewe.cosy.sbg.ac.at") by vger.kernel.org with ESMTP
	id <S315884AbSEQMm3>; Fri, 17 May 2002 08:42:29 -0400
Date: Fri, 17 May 2002 14:41:51 +0200 (MET DST)
From: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
To: Halil Demirezen <halild@bilmuh.ege.edu.tr>
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Just an offer
In-Reply-To: <20020517122946.18213.qmail@bilmuh.ege.edu.tr>
Message-ID: <Pine.GSO.4.05.10205171440170.11141-100000@mausmaki.cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 May 2002, Halil Demirezen wrote:

> 
> I wonder if there is a way of making the kernel decide whether it can boot successfully or not. For example, lets think of that i am compiling an update kernel not on the local machine but on any other pc using telnet or ssh emulators. And eventually it is time to reboot the machine and and run on the new kernel. However there has been an error during the compiling. - such as misconfiguration. Normally the machine will not boot and halt. So, is not there any way to reboot itself from the previous kernel after some time that it realizes it cannot boot properly. Maybe there is such a way. But, if not, this is an imaginary. Because i usually see these kind of problems ;)


usually you'll use a hardware watchdog for that purpose. - but you need
to be sure to instruct your bootloader to boot the old image when the watchdog
reboots your machine ...

	tm
-- 
in some way i do, and in some way i don't.

