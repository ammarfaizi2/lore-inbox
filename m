Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315257AbSGQPjM>; Wed, 17 Jul 2002 11:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315245AbSGQPjM>; Wed, 17 Jul 2002 11:39:12 -0400
Received: from mailrelay.ds.lanl.gov ([128.165.47.40]:26774 "EHLO
	mailrelay.ds.lanl.gov") by vger.kernel.org with ESMTP
	id <S315257AbSGQPjL>; Wed, 17 Jul 2002 11:39:11 -0400
Subject: Re: Linux 2.4.19-rc1-ac7
From: Steven Cole <scole@lanl.gov>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org, cleverdj@ibm.us.com
In-Reply-To: <200207171056.g6HAuXR24678@devserv.devel.redhat.com>
References: <200207171056.g6HAuXR24678@devserv.devel.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 17 Jul 2002 09:39:00 -0600
Message-Id: <1026920340.11636.63.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-17 at 04:56, Alan Cox wrote:

> Linux 2.4.19rc1-ac7

> o	Hopefully fix the SMP APIC problems rc6		(James Cleverdon)
> 	gave some people

Not yet fixed for me. Here is the error shortly after the very beginning
of the boot:

APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
message repeats at this point.

This is on a VALinux 2231 dual p-III with an Intel Server Board STL2.
Same .config which I sent last time.  I can resend if necessary.

CONFIG_SMP=y for this kernel.

[steven@spc9 linux-2.4.19-rc1-ac7]$ grep APIC .config
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y

Steven

