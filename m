Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262657AbTHUW7I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 18:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbTHUW7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 18:59:08 -0400
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:41562 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262657AbTHUW7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 18:59:07 -0400
Message-ID: <3F454F46.3000207@sbcglobal.net>
Date: Thu, 21 Aug 2003 18:01:26 -0500
From: Wes Janzen <superchkn@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Manually setting timings on PDC20269
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is there any way to manually set the UDMA timings used to interface with 
a drive?

I can see in the PDC20269 driver that it is responsible for setting the 
timings, but I'm not sure how to adjust them at runtime.  My UDMA-2 
drive reverts to PIO after trying a write.  Oddly, I can read from the 
drive using UDMA, it just times out and reverts to PIO when I try to 
write anything to it.

This is with kernel 2.6.0-test3...

Thanks,

Wes

