Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262907AbTJ3W1x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 17:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262909AbTJ3W1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 17:27:53 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41875 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262907AbTJ3W1v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 17:27:51 -0500
Message-ID: <3FA19059.1030106@pobox.com>
Date: Thu, 30 Oct 2003 17:27:37 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrik Wallstrom <pawal@blipp.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH #2] Re: SATA and 2.6.0-test9
References: <20031027141531.GD15558@vic20.blipp.com> <20031027165809.GD19711@gtf.org> <20031027181052.GG32168@vic20.blipp.com> <3FA14F2F.1080700@pobox.com> <20031030222518.GL10457@vic20.blipp.com>
In-Reply-To: <20031030222518.GL10457@vic20.blipp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrik Wallstrom wrote:
> On Thu, 30 Oct 2003, Jeff Garzik wrote:
> 
> 
>>>It doesn't hang any more, but the only result is:
>>>sata_via version 0.11
>>>ata3: SATA max UDMA/133 cmd 0xD800 ctl 0xD402 bmdma 0xC800 irq 16
>>>ata4: SATA max UDMA/133 cmd 0xD000 ctl 0xCC02 bmdma 0xC808 irq 16
>>>ata3: thread exiting
>>>scsi2 : sata_via
>>>ata4: thread exiting
>>>scsi3 : sata_via
>>
>>Actually, attached is a better patch...
> 
> 
> Still get the same result as above.

Ok, thanks for testing.


> Is there any way to know why the thread is exiting?

That's normal, when it cannot find a device on that port.

	Jeff




