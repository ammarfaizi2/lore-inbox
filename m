Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbTJ2FDJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 00:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbTJ2FDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 00:03:08 -0500
Received: from mail-08.iinet.net.au ([203.59.3.40]:41438 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261895AbTJ2FDG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 00:03:06 -0500
Message-ID: <3F9F4841.2040904@cyberone.com.au>
Date: Wed, 29 Oct 2003 15:55:29 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: SiS ISA bridge IRQ routing on 2.6 ...
References: <Pine.LNX.4.56.0310281931510.933@bigblue.dev.mdolabs.com>
In-Reply-To: <Pine.LNX.4.56.0310281931510.933@bigblue.dev.mdolabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Davide Libenzi wrote:

>Linus, I saw that Marcelo merged Alan bits to fix the IRQ routing with the
>newest SiS ISA bridges. To make it really short the ISA bridge inside the
>SiS 85C503/5513 issue IRQ routing requests on 0x60, 0x61, 0x62 and 0x63
>for the USB hosts and the current code does not handle them correctly.
>2.6-test9 does not have those bits and the USB  subsystem won't work w/out
>that. Did Alan ever posted the patch for 2.6? If yes, did you simply miss
>it or you have a particular reason to not merge it?
>I really would like to remove the SiS IRQ patch from my to-apply-2.6
>folder :)
>
>

Alan thought I should put SiS IRQ routing on the must-fix list.
Doesn't mean it has to go in before 2.6.0, but if its common
hardware and its in 2.4 without problems its probably a good idea.


