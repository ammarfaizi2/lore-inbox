Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287915AbSACBJy>; Wed, 2 Jan 2002 20:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288094AbSACBJo>; Wed, 2 Jan 2002 20:09:44 -0500
Received: from relais.videotron.ca ([24.201.245.36]:7588 "EHLO
	VL-MS-MR003.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id <S287915AbSACBJh>; Wed, 2 Jan 2002 20:09:37 -0500
Message-ID: <3C33AF4F.7000703@videotron.ca>
Date: Wed, 02 Jan 2002 20:09:35 -0500
From: Roger Leblanc <r_leblanc@videotron.ca>
Organization: General DataComm
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010914
X-Accept-Language: en-us
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Deadlock in kernel on USB shutdown
In-Reply-To: <3C33A22F.40906@videotron.ca> <20020103001816.GB4162@kroah.com> <3C33A4EC.1040300@videotron.ca> <20020103002827.GA4462@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>>Greg KH wrote:
>>
>>>Have you unloaded your scanner module before unloading the usb-uhci
>>>module?
>>>
>>No. Actually, I don't even know how it's called. How can I find out?
>>
>
>I think it's called "scanner".  Just look for any module that the
>usbcore module shows as "Used by".
>
Mmmm, I should have guessed that one. Scanner is quite a good name for a 
scanner module ;-). Anyway, I moved things around so "scanner" and all 
the other device specific modules are unloaded before usb-uhci but yet, 
it doesn't help. It still freeses when unload usb-uhci. Any idea?

Thanks

Roger


