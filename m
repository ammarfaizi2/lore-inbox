Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262281AbTHYWNA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 18:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262309AbTHYWNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 18:13:00 -0400
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:6267 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262281AbTHYWM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 18:12:58 -0400
Message-ID: <3F4A8A8D.90403@sbcglobal.net>
Date: Mon, 25 Aug 2003 17:15:41 -0500
From: Wes Janzen <superchkn@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: pci=irqmask=0xffdf has no effect on 2.6.0-test3/2.6.0-test4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to mask off IRQ's so the kernel won't assign my PCI devices 
to 3,4,5, or 7.  I believe that mask I have above is for IRQ 5, but it 
doesn't have any effect with 2.6.0-test3/4.  It does work on kernel 2.4.18.

Has this changed on the kernel and just hasn't been documented in the 
docs or am I passing the wrong parameter for preventing the kernel from 
using IRQs?

Thanks,

Wes

