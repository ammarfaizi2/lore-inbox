Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264896AbUEQF1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264896AbUEQF1O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 01:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264891AbUEQF1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 01:27:14 -0400
Received: from mail.tpgi.com.au ([203.12.160.61]:56006 "EHLO mail4.tpgi.com.au")
	by vger.kernel.org with ESMTP id S264896AbUEQF0n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 01:26:43 -0400
Message-ID: <40A84C27.90803@linuxmail.org>
Date: Mon, 17 May 2004 15:22:47 +1000
From: Nigel Cunningham <ncunningham@linuxmail.org>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rajsekar <raj.delete.se.here.too.kar@peacock.iitm.ernet.in>
CC: linux-kernel@vger.kernel.org
Subject: Re: swsusp also stores system clock
References: <y49oeonr88c.fsf@sahana.cs.iitm.ernet.in>
In-Reply-To: <y49oeonr88c.fsf@sahana.cs.iitm.ernet.in>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The solution to this is to run

/sbin/hwclock --hctosys

after resuming. You might need to add --direct-isa if this hangs.

Regards,

Nigel

Rajsekar wrote:
> I started liking swsusp so much that I dont shutdown my system anymore, I
> just suspend.  Is this wrong? 
> 
> But I noticed that the clock also gets saved and when I resume my system,
> the clock is annoyingly wrong.  I suppose that this is done on purpose for
> some reasons by the developers.
> 
> Currently, I use hwclock to set my system clock on resume.
> 
> Is there a better way or a patch ?
> 


-- 
Nigel & Michelle Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6254 0216 (home)

Evolution (n): A hypothetical process whereby infinitely improbable 
events occur
with alarming frequency, order arises from chaos, and no one is given 
credit.
