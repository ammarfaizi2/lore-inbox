Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312414AbSDNTCU>; Sun, 14 Apr 2002 15:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312418AbSDNTCT>; Sun, 14 Apr 2002 15:02:19 -0400
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:10997 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S312414AbSDNTCT>; Sun, 14 Apr 2002 15:02:19 -0400
Message-ID: <3CB9D20C.30000@wanadoo.fr>
Date: Sun, 14 Apr 2002 21:01:32 +0200
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9+) Gecko/20020407
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ian Molton <spyro@armlinux.org>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: usb-uhci *BUG*
In-Reply-To: <20020414004022.6450f038.spyro@armlinux.org> <20020414150719.GA17826@kroah.com> <20020414183247.016a2ec3.spyro@armlinux.org> <20020414164355.GA18040@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Sun, Apr 14, 2002 at 06:32:47PM +0100, Ian Molton wrote:
> 
>>>What devices do you have plugged in?
>>
>>one alcatel usb speedtouch ADSL modem, using the 'user mode' driver.
> 
> 
> Ah, please try using the patch below from David Brownell to fix this
> problem.  I've already applied this to my trees, and will get pushed to
> the main kernels soon.

The oops doesn't come when the driver is exiting in this case (as the 
patch was for), it "occurs randomly". The problem might be with the usb 
hardware.

> Ian Molton wrote:
>>>What were you doing when the BUG() call happened?
>> 
>> surfin' the net ;) it appears to occur randomly - its been fine the whole
>> day today, although less stressed than yesterday.

What is the motherboard, is it an usb add-on card ?



Pierre
------------------------------------------------
  Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------

