Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S264202AbUE2JJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264202AbUE2JJX (ORCPT <rfc822;akpm@zip.com.au>);
	Sat, 29 May 2004 05:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264210AbUE2JJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 05:09:23 -0400
Received: from mail.tpgi.com.au ([203.12.160.101]:28811 "EHLO
	mail5.tpgi.com.au") by vger.kernel.org with ESMTP id S264202AbUE2JJW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 05:09:22 -0400
Message-ID: <40B85024.2040505@linuxmail.org>
Date: Sat, 29 May 2004 18:56:04 +1000
From: Nigel Cunningham <ncunningham@linuxmail.org>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stuart Young <cef-lkml@optusnet.com.au>
CC: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Rob Landley <rob@landley.net>, seife@suse.de
Subject: Re: swappiness=0 makes software suspend fail.
References: <200405280000.56742.rob@landley.net> <20040528215642.GA927@elf.ucw.cz> <200405291905.20925.cef-lkml@optusnet.com.au>
In-Reply-To: <200405291905.20925.cef-lkml@optusnet.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Stuart Young wrote:
> On Sat, 29 May 2004 07:56, Pavel Machek wrote:
> 
>>Stefan, we may want to do echo 100 > /proc/sys/vm/swappiness in
>>suspend script...
> 
> 
> Really, you should save that value somewhere and then restore it after 
> suspend, or those people who do use /proc/sys/vm/swappiness will likely 
> complain about it (ie: me).

Yes. This doesn't need to be done by the script. I'll change suspend2 so it saves and restores the 
value.

Nigel
-- 
Nigel & Michelle Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (417) 100 574 (mobile)

After homosexuality, they'll be arguing paedophilia is normal.
