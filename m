Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268721AbTBZLrz>; Wed, 26 Feb 2003 06:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268722AbTBZLrz>; Wed, 26 Feb 2003 06:47:55 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:24074 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S268721AbTBZLrx>; Wed, 26 Feb 2003 06:47:53 -0500
Message-Id: <200302261151.h1QBp2s23777@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: wyleus <coyote1@cytanet.com.cy>, linux-kernel@vger.kernel.org
Subject: Re: syslog full of kernel BUGS, frequent intermittent instability
Date: Wed, 26 Feb 2003 13:48:03 +0200
X-Mailer: KMail [version 1.3.2]
References: <20030226041214.71e1ddc7.coyote1@cytanet.com.cy>
In-Reply-To: <20030226041214.71e1ddc7.coyote1@cytanet.com.cy>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 February 2003 11:12, wyleus wrote:
> Hi folks,
>
> My recently installed Mandrake 9.0 has been unstable since day one. 
> The syslog is full of kernel BUG lines (see below), the crashes are
> frequent, and I don't know how to reproduce them - recognize no
> pattern to them.
>
> I have run memtest86 overnight (~13 hours) - it reported no errors. 
> So would I be correct in assuming that my RAM can be ruled out?  I
> have also passed both the "noapic" and "mem=nopentium" parameters to
> lilo, but that hasn't resulted in any noticeable improvement.

cpuburn will help you rule out defective CPU theory.
Also you can start removing/swapping hardware parts.

> I would appreciate any insight anyone can provide.  Let me know if I
> can provide any more info.

Test with some vanilla 2.4 kernels, not a distro one. If 2.4.20 crashes,
try some of the earlier kernels too. Compile them for 386 uniprocessor
with debugging and magic SysRq enabled. Provide your .config

Run your klogd with -x to make it stop decoding oopses.
Run oopses thru ksymoops and provide result.
Provide lsmod, lspci output, some of /proc/* files (interrupts etc)

> I haven't suscribed to this ML because I don't want the volume in my
> mailbox - but will monitor this thread through google groups.

People are going to CC you I believe, so don't worry.
--
vda

