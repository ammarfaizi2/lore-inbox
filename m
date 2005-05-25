Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262253AbVEYCnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbVEYCnw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 22:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbVEYCnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 22:43:52 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:37735 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S262247AbVEYCmK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 22:42:10 -0400
Message-ID: <4293E62A.5080408@danbbs.dk>
Date: Wed, 25 May 2005 04:42:50 +0200
From: Mogens Valentin <monz@danbbs.dk>
Reply-To: monz@danbbs.dk
Organization: Mr Dev
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dougg@torque.net
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: [ANNOUNCE] sdparm 0.92
References: <428DC633.5050403@torque.net> <4293BD80.1050503@danbbs.dk> <4293D798.4020606@torque.net>
In-Reply-To: <4293D798.4020606@torque.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Douglas Gilbert wrote:
> Mogens Valentin wrote:
> 
>> Douglas Gilbert wrote:
>>
>>> sdparm is a command line utility designed to get and set
>>> SCSI disk parameters (cf hdparm for ATA disks). ..snip..
>>
>> Nice! Just got it and tried on an external usb disk.
>> One feature I could use, probably others as well:
>> Could you add the ability to spin down/up a scsi disk?
>> I'd really like this for exteral (usb) disks.
> 
> Mogens,
> With sg_start (in the sg3_utils package) I have tried
> to spin up and down an ATA disk inside a USB enclosure
> without success. The same command on a USB connected
> CD/DVD combo drive did work.
> 
> Could you try sg_start on your USB external enclosure
> which I assume contains an ATA disk rather than a
> SCSI (SPI) disk and report if it works?

Sure. Got it, compiled, but got the error:
   .../usr/include/scsi/sg.h /usr/include/scsi/scsi.h
   /usr/include/stdint.h   sg_lib.h sg_cmds.h llseek.h
   gcc: cannot specify -o with -c or -S and multiple compilations
   make: *** [sgp_dd.o] Error 1

I could only find  -o  and  -c  in the makefiles around line 95.

Slack 9.1 / 2.6.10 from sources.

It's 4am, I'm off to bed, sorry :p

-- 
Kind regards,
Mogens Valentin

