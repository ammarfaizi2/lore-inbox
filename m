Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268616AbUHLRC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268616AbUHLRC3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 13:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268617AbUHLRC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 13:02:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33491 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268616AbUHLRCC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 13:02:02 -0400
Message-ID: <411BA27C.7030801@pobox.com>
Date: Thu, 12 Aug 2004 13:01:48 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SG_IO and security
References: <1092313030.21978.34.camel@localhost.localdomain> <Pine.LNX.4.58.0408120929360.1839@ppc970.osdl.org> <Pine.LNX.4.58.0408120943210.1839@ppc970.osdl.org> <411BA0F4.9060201@pobox.com>
In-Reply-To: <411BA0F4.9060201@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Linus Torvalds wrote:
> 
>>
>> On Thu, 12 Aug 2004, Linus Torvalds wrote:
>>
>>> Hmm.. This still allows the old "junk" commands 
>>> (SCSI_IOCTL_SEND_COMMAND).
>>
>>
>>
>> Btw, I think the _right_ thing to check is the write access of the 
>> file descriptor. If you have write access to a block device, you can 
>> delete the data, so you might as well be able to do the raw commands. 
>> And that would allow things like "disk" groups etc to work and burn CD's.
> 
> 
> 
> Define raw commands.  I certainly don't want non-root users to be able 
> to issue FORMAT UNIT on my hard drive.

oh, to the block device, not the file.

nevermind.

	Jeff



