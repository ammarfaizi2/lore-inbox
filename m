Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315218AbSFDQ7B>; Tue, 4 Jun 2002 12:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315232AbSFDQ7A>; Tue, 4 Jun 2002 12:59:00 -0400
Received: from [195.63.194.11] ([195.63.194.11]:41996 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315218AbSFDQ67>; Tue, 4 Jun 2002 12:58:59 -0400
Message-ID: <3CFCE41A.4030005@evision-ventures.com>
Date: Tue, 04 Jun 2002 18:00:26 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: device model documentation 1/3
In-Reply-To: <Pine.LNX.4.33.0206040904430.654-100000@geena.pdx.osdl.net> <3CFCE09B.6090007@evision-ventures.com> <20020604165345.GB28805@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Tue, Jun 04, 2002 at 05:45:31PM +0200, Martin Dalecki wrote:
> 
>>Patrick Mochel wrote:
>>
>>
>>>Bus Types 
>>>
>>>struct bus_type {
>>
>>...
>>
>>
>>
>>>	int	(*bind)		(struct device * dev, struct device_driver * 
>>>	drv);
>>>};
>>>
>>
>>Please - Why do you call it bind? Does it have something with
>>netowrking to do? Please just name it attach. This way the old UNIX
>>guys among us won't have to drag a too big
>>"UNIX to Linux translation dictionary" around with them.
>>As an "added bonus" you will stay consistent with -
>>
>>USB code base in kernel
> 
> 
> Huh?  The usb code base doesn't use either "bind" or "attach" in it's
> api.
> 
> And who cares?  You knew what he ment by this, and it's a pretty
> standard term.

I care. And I had to thing long and hard before guessing what it could
be. (I noticed this nomenclature error already in the kernel patch.)


