Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbTHTXli (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 19:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262334AbTHTXli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 19:41:38 -0400
Received: from smtp806.mail.sc5.yahoo.com ([66.163.168.185]:13358 "HELO
	smtp806.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262272AbTHTXlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 19:41:35 -0400
Message-ID: <3F440387.5090902@sbcglobal.net>
Date: Wed, 20 Aug 2003 18:25:59 -0500
From: Wes Janzen <superchkn@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test3-mm3 reserve IRQ for isapnp
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So sad...  Ever since I started with kernel 2.5.69, the kernel has been 
properly reserving IRQ 5 for ISA, as set in my BIOS.

Unfortunately for me, it looks like 2.6.0-test3-mm3 is like 2.4.18 and 
ignores my BIOS settings, so it locks up trying to ativate my SB16 on 
boot (since IRQ 5 is used for IDE).  Oddly it doesn't spit out any 
warnings, just locks up after "pnp: Device 00:01.03 activated". 

I used "pci=irqmask=0xffdf" in 2.4.18, but that doesn't seem to work for 
2.6.0-test3-mm3.  I'm not positive I'm giving it the correct value 
though...so maybe that's the problem.

I'd really like to try out the O17int version of mm3, but I don't want 
to disable sound either.

Thanks!

Wes

