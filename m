Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266600AbUFRTjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266600AbUFRTjq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 15:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266536AbUFRTfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 15:35:30 -0400
Received: from mailgate.uni-paderborn.de ([131.234.22.32]:23425 "EHLO
	mailgate.uni-paderborn.de") by vger.kernel.org with ESMTP
	id S266599AbUFRTeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 15:34:23 -0400
Message-ID: <40D343B6.4010302@uni-paderborn.de>
Date: Fri, 18 Jun 2004 21:34:14 +0200
From: Bjoern Schmidt <bj-schmidt@uni-paderborn.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Via-Rhine ethernet driver problem?
References: <40685BC9.1040902@myrealbox.com>
In-Reply-To: <40685BC9.1040902@myrealbox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-UNI-PB_FAK-EIM-MailScanner-Information: Please see http://imap.uni-paderborn.de for details
X-UNI-PB_FAK-EIM-MailScanner: Found to be clean
X-UNI-PB_FAK-EIM-MailScanner-SpamCheck: not spam, SpamAssassin (score=-4.275,
	required 4, AUTH_EIM_USER -5.00, RCVD_IN_NJABL 0.10,
	RCVD_IN_NJABL_DIALUP 0.53, RCVD_IN_SORBS 0.10)
X-MailScanner-From: bj-schmidt@uni-paderborn.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

walt wrote:

[...]

> I also discovered by using 'scp' to copy files between machines that the 
> bad
> performance is assymetrical:  copying a file *to* this machine runs at 
> about
> half-speed (5 MB/sec) whereas copying a file *from* this machine runs at
> 45 KiloB/sec, about one percent of expected.

I have exactly the same problem on a asrock k7vt2 with VIA's Rhine II:

megabyte:~# uname -a
Linux megabyte 2.6.7 #1 Fri Jun 18 20:37:37 CEST 2004 i686 GNU/Linux

=================================================================

megabyte:~# lspci -v
0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 
[Rhine-II] (rev 74)
         Subsystem: VIA Technologies, Inc. VT6102 [Rhine-II]
         Flags: bus master, medium devsel, latency 64, IRQ 11
         I/O ports at dc00
         Memory at dffffe00 (32-bit, non-prefetchable) [size=256]
         Capabilities: [40] Power Management version 2

==================================================================

		up 		down
100baseTx-FD:	~45 kB/s	~100 MBit/s
100baseTx: 	~45 kB/s	~100 MBit/s
10baseT-FD: 	~45 kB/s	~10  MBit/s
10baseT:	~10 MBit/s	~10  MBit/s



-- 
Greetings
Bjoern Schmidt

