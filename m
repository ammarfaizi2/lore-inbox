Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbTEESB6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 14:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbTEESB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 14:01:58 -0400
Received: from mx1.it.wmich.edu ([141.218.1.89]:58022 "EHLO mx1.it.wmich.edu")
	by vger.kernel.org with ESMTP id S261176AbTEESB4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 14:01:56 -0400
Message-ID: <3EB6AA01.30601@wmich.edu>
Date: Mon, 05 May 2003 14:14:25 -0400
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030318
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: CaT <cat@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.68-bk7: Where oh where have my sensors gone? (i2c)
References: <20030427115644.GA492@zip.com.au> <20030428205522.GA26160@kroah.com> <20030505083458.GA621@zip.com.au> <20030505165848.GA1249@kroah.com>
In-Reply-To: <20030505165848.GA1249@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hey guys.  Notice a missing proc driver? hint: i2c.    That's why 
sensors wont work even when you load the modules. At least that's what i 
can tell from what the lm_sensors page mentions and what not.


Greg KH wrote:
> On Mon, May 05, 2003 at 06:34:58PM +1000, CaT wrote:
> 
>>On Mon, Apr 28, 2003 at 01:55:22PM -0700, Greg KH wrote:
>>
>>>On Sun, Apr 27, 2003 at 09:56:44PM +1000, CaT wrote:
>>>
>>>>I keep a-lookin but I can't find any data. Have I missed something?
>>>>
>>>># find | grep -i pii
>>>>./bus/pci/drivers/piix4 smbus
>>>>./bus/pci/drivers/piix4 smbus/00:07.3
>>>>./bus/pci/drivers/PIIX IDE
>>>>./bus/pci/drivers/PIIX IDE/00:07.1
>>>># find | grep -i i2c
>>>>./bus/i2c
>>>>./bus/i2c/drivers
>>>>./bus/i2c/drivers/lm75
>>>>./bus/i2c/drivers/IT87xx
>>>>./bus/i2c/drivers/dev driver
>>>>./bus/i2c/devices
>>>
>>>No devices?  Does 2.5.68 work for you?
>>
>>Does not look like it:
> 
> 
> Ok, but 2.5.67 worked for you, right?  Care to do a binary search
> through the different -bk trees inbetween to find where it stopped
> working for you?
> 
> thanks,
> 
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


