Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268802AbUJKLV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268802AbUJKLV7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 07:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268800AbUJKLV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 07:21:59 -0400
Received: from foss.kharkov.ua ([195.69.184.25]:2183 "EHLO
	relay.foss.kharkov.ua") by vger.kernel.org with ESMTP
	id S268802AbUJKLV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 07:21:57 -0400
X-AV-Checked: Mon Oct 11 14:21:53 2004 passed
Message-ID: <416A6CF8.5050106@kharkiv.com.ua>
Date: Mon, 11 Oct 2004 14:22:32 +0300
From: Oleksiy <Oleksiy@kharkiv.com.ua>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: pl2303/usb-serial driver problem in 2.4.27-pre6
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have a problem using GPRS inet vi my Siemens S55 attached with USB 
cable since kernel version 2.4.27-pre5, the link is established well, 
but then no packets get received, looking with tcpdump shows outgoing 
ping packets and just few per several minutes received back. I'm unable 
to ping, do nslookup, etc.
The problem started when i switched from kernel 2.4.26 (linux slackware 
10.0) to 2.4.28-pre3. None of ppp otions haven't changed and all the 
same options were set during kerenel config. So i decided to test all 
kernels between 2.4.26 and 2.4.28-pre4 (also not working). Link works 
well in 2.4.27-pre5 and stop working in 2.4.27-pre6. No "strange" 
messages or errors in the logs. firewall is disabled (ACCEPT for all).

i'm using:

pppd-2.4.2
Siemens S55 mobile
USB cable (PL2303 conroller)

USB drivers:

ehci_hcd
uhci.c
pl2303.c

Thanks.

-- 
Oleksiy
http://voodoo.com.ua

