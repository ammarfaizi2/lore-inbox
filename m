Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316210AbSHORYM>; Thu, 15 Aug 2002 13:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316213AbSHORYM>; Thu, 15 Aug 2002 13:24:12 -0400
Received: from [143.166.83.88] ([143.166.83.88]:29445 "HELO
	AUSADMMSRR501.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S316210AbSHORYL>; Thu, 15 Aug 2002 13:24:11 -0400
X-Server-Uuid: ff595059-9672-488a-bf38-b4dee96ef25b
Message-ID: <20BF5713E14D5B48AA289F72BD372D6821CB53@AUSXMPC122.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: linux-kernel@vger.kernel.org
cc: marcelo@conectiva.com.br, alan@lxorguk.ukuu.org.uk, davej@suse.de,
       torvalds@transmeta.com, andersen@codepoet.org, davidm@hpl.hp.com
Subject: RE: Linux 2.4.20-pre1
Date: Thu, 15 Aug 2002 12:28:00 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 11453B287679646-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd be happy to submit a patch moving asm-ia64/efi.h into 
> include/linux/ if it would be accepted.

I've submitted patches to David Mosberger against 2.4 and 2.5 BK current,
and the latest 2.4 ia64 port patch, which moves efi.h from include/asm-ia64
into include/linux.  This is important now that the GUID Partition Table
(GPT) code is included in the stock 2.4 and 2.5 kernels, and can be used on
non-IA64 platforms - specifically for handling really large disks.  There is
no ia64-specific code in efi.h.  David agrees that it's proper to make this
change.
 
I've asked David, as IA64 port maintainer who currently "owns" this file, to
forward these to Alan, Marcelo, DaveJ, and Linus respectively.

For the curious, the posts to linux-ia64 with patches and explanations:

For 2.5 BK-current:
https://external-lists.vasoftware.com/archives//linux-ia64/2002-August/00385
1.html
https://external-lists.vasoftware.com/archives//linux-ia64/2002-August/00385
2.html

For 2.4 BK-current and ia64-current:
https://external-lists.vasoftware.com/archives//linux-ia64/2002-August/00385
3.html


Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
#1 US Linux Server provider for 2001 and Q1/2002! (IDC May 2002)

