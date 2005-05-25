Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbVEYUqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbVEYUqT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 16:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbVEYUqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 16:46:19 -0400
Received: from 64-30-195-78.dsl.linkline.com ([64.30.195.78]:33184 "EHLO
	jg555.com") by vger.kernel.org with ESMTP id S261552AbVEYUqP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 16:46:15 -0400
Message-ID: <4294E409.9020907@jg555.com>
Date: Wed, 25 May 2005 13:46:01 -0700
From: Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ross Biro <ross.biro@gmail.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Random IDE Lock ups with via IDE
References: <4293B859.3070609@jg555.com> <4294BAE8.5050803@jg555.com> <8783be6605052513343fce843b@mail.gmail.com>
In-Reply-To: <8783be6605052513343fce843b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ross,
    I thought of that to, I just have 2 laptops that are identical here 
now. I have placed a different drive in the other one. So we can test 
it, but looking through all my logs that I backed up, this problem 
started when I put 2.6.8 on the laptop. I'm wondering if it could be an 
ACPI issue or IDE issue, but have no idea on what to really look for.

May 24 16:22:31 laptop kernel: mtrr: 0x40000000,0x800000 overlaps 
existing 0x40000000,0x400000
May 24 18:25:11 laptop kernel: hda: status timeout: status=0xd0 { Busy }
May 24 18:25:11 laptop kernel:
May 24 18:25:11 laptop kernel: ide: failed opcode was: unknown
May 24 18:25:11 laptop kernel: hda: no DRQ after issuing MULTWRITE
May 24 18:25:12 laptop kernel: ide0: reset: success

May 24 12:21:15 laptop2 kernel: mtrr: 0x40000000,0x800000 overlaps 
existing 0x40000000,0x400000
May 24 16:55:53 laptop2 kernel: hda: status timeout: status=0xd0 { Busy }
May 24 16:55:53 laptop2 kernel:
May 24 16:55:54 laptop2 kernel: ide: failed opcode was: unknown
May 24 16:55:54 laptop2 kernel: hda: no DRQ after issuing MULTWRITE
May 24 16:55:54 laptop2 kernel: ide0: reset: success

Here is a link to my .config file
http://ftp.jg555.com/configs/laptop.config
