Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264682AbSJTX7w>; Sun, 20 Oct 2002 19:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264685AbSJTX7w>; Sun, 20 Oct 2002 19:59:52 -0400
Received: from mail.tpgi.com.au ([203.12.160.58]:23433 "EHLO mail2.tpgi.com.au")
	by vger.kernel.org with ESMTP id <S264682AbSJTX7u>;
	Sun, 20 Oct 2002 19:59:50 -0400
Message-ID: <3DB3442A.7050002@tpg.com.au>
Date: Mon, 21 Oct 2002 10:02:50 +1000
From: Bill Leckey <bleckey@tpg.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020514
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: System lockup.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a terminal server that's supporting up to 240 lines.  It's a 
2.4.17 kernel, and is running squid, and using the reiser file system to 
store log files, squid cache and other data.  About every day or so, the 
machine locks up.  The screen is blank, keyboard doesn't respond, the 
serial console I set up shows no 'dying gasp' and there is nothing in 
any of the system logs.

This doesn't appear to be related to load as it has happened both during 
the busiest times and during the low times.

I'm still servicing interrupts from our serial devices (on IRQ 11), so 
it seems interrupts are still happening.

Beyond this, however, I have no idea where to go from here.  If anyone 
has any hints on what the problem might be, or even a way to gather more 
information, I would be grateful.

-- 
Bill Leckey - Senior Software Design Engineer
TPG Research and Development
Ph: +61 2 62851711
Fax: +61 2 62853939

