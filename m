Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbTIYHmQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 03:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbTIYHmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 03:42:16 -0400
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:63427 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S261748AbTIYHmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 03:42:14 -0400
Message-ID: <3F729C36.20709@ppp0.net>
Date: Thu, 25 Sep 2003 09:41:42 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030913 Thunderbird/0.4a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Yaroslav Halchenko <yoh@onerussian.com>, linux-kernel@vger.kernel.org
Subject: Re: USB problem. 'irq 9: nobody cared!'
References: <20030921184149.GA12274@washoe.rutgers.edu> <20030922063324.GF3398@ppp0.net> <20030923050848.GA5917@washoe.rutgers.edu> <20030923094746.GA22232@ppp0.net> <20030924204846.GS11234@kroah.com>
In-Reply-To: <20030924204846.GS11234@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Tue, Sep 23, 2003 at 11:47:46AM +0200, Jan Dittmer wrote:
>>
>>Greg, what is going on here? In a nutshell: Irq 9 gets disabled on boot
>>and all other devices on this irq consequently doesn't work any more.
>>Here is the oops from dmesg again:
> 
> 
> There's no "oops" here, just a warning message.  Things worked just fine
> after this, right?
> 

No, read my message, irq 9 doesn't get reenabled again. And as my nic is 
also on this interrupt, it cannot receive any packets anymore, usb 
doesn't work, acpi doesn't work:

9:     100000          XT-PIC  acpi, uhci-hcd, uhci-hcd, ohci1394, Intel 
82801BA-ICH2, eth0, 0000:01:02.0,
0000:01:05.0, orinoco_cs

Thanks,

Jan

