Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268577AbTCCQsu>; Mon, 3 Mar 2003 11:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268583AbTCCQsu>; Mon, 3 Mar 2003 11:48:50 -0500
Received: from air-2.osdl.org ([65.172.181.6]:40394 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268577AbTCCQso>;
	Mon, 3 Mar 2003 11:48:44 -0500
Date: Mon, 3 Mar 2003 08:54:03 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: scott-kernel@thomasons.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: SCSI emulation causes kernel panic
Message-Id: <20030303085403.263559e8.rddunlap@osdl.org>
In-Reply-To: <200303021601.24433.scott-kernel@thomasons.org>
References: <200303021601.24433.scott-kernel@thomasons.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Mar 2003 16:01:24 -0600
scott thomason <scott-kernel@thomasons.org> wrote:

| Greetings. I haven't been able to find a single version yet in 
| the 2.5.x series that allows me to use SCSI emulation without a 
| kernel panic...until I tried a strange trick today. Even under 
| 2.5.63, I still received the panic documented below, until I 
| turned on all the options under "Kernel Hacking". Then SCSI 
| emulation seems to work fine!
| 
| Some details: I have a dual Athlon MP2000 on an ASUS A7M266-D, 
| with a new IDE-ATAPI Plexwriter. I have attached the dmesg/klogd 
| output, the kernel panic that I painstakingly transcribed by 
| hand, and the kernel configuration I used. If there is anything 
| else needed...let me know!
| ---scott

Need to run that oops report thru ksymoops (see the file
linux/Documentation/oops-tracing.txt) or turn on
CONFIG_KALLSYMS=y in the Kernel Hacking menu to decode all of those
hex addresses.

--
~Randy
