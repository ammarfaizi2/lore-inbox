Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264208AbUE2JAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264208AbUE2JAY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 05:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264210AbUE2JAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 05:00:24 -0400
Received: from mail.tpgi.com.au ([203.12.160.113]:16101 "EHLO
	mail6.tpgi.com.au") by vger.kernel.org with ESMTP id S264208AbUE2JAX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 05:00:23 -0400
Message-ID: <40B84E11.4070305@linuxmail.org>
Date: Sat, 29 May 2004 18:47:13 +1000
From: Nigel Cunningham <ncunningham@linuxmail.org>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nigel Cunningham <ncunningham@linuxmail.org>
CC: Pavel Machek <pavel@ucw.cz>, swsusp-devel@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Swsusp-devel] Re: suspend2 problems on SMP machine, incorrect
 tainting
References: <20040528103549.GA2789@elf.ucw.cz> <40B83D05.1020701@linuxmail.org>
In-Reply-To: <40B83D05.1020701@linuxmail.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again.

Nigel Cunningham wrote:
> Yes. It needs to be atomic (it's the atomic copy) and pages might well 
> be HighMem so I guess the answer is to suppress the message rather than 
> changing something in suspend.

Before someone says it, yes. I mean using kmap_atomic :>

Nigel
-- 
Nigel & Michelle Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (417) 100 574 (mobile)

After homosexuality, they'll be arguing paedophilia is normal.
