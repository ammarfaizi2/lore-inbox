Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288130AbSACCKh>; Wed, 2 Jan 2002 21:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288109AbSACCK1>; Wed, 2 Jan 2002 21:10:27 -0500
Received: from relais.videotron.ca ([24.201.245.36]:10629 "EHLO
	VL-MS-MR004.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id <S288126AbSACCKS>; Wed, 2 Jan 2002 21:10:18 -0500
Message-ID: <3C33BD88.3010903@videotron.ca>
Date: Wed, 02 Jan 2002 21:10:16 -0500
From: Roger Leblanc <r_leblanc@videotron.ca>
Organization: General DataComm
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010914
X-Accept-Language: en-us
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Deadlock in kernel on USB shutdown
In-Reply-To: <3C33A22F.40906@videotron.ca> <20020103001816.GB4162@kroah.com> <3C33A4EC.1040300@videotron.ca> <20020103002827.GA4462@kroah.com> <3C33AF4F.7000703@videotron.ca> <20020103013231.GA4952@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Greg KH wrote:

>On Wed, Jan 02, 2002 at 08:09:35PM -0500, Roger Leblanc wrote:
>
>>Mmmm, I should have guessed that one. Scanner is quite a good name for a 
>>scanner module ;-). Anyway, I moved things around so "scanner" and all 
>>the other device specific modules are unloaded before usb-uhci but yet, 
>>it doesn't help. It still freeses when unload usb-uhci. Any idea?
>>
>
>Hm, if you umount usbdevfs before unloading usb-uhci, does that work?
>
umount seg-faults while unmounting /proc/bus/usb! Then modprobe also 
seg-faults while unloading usb-uhci!!! But the system stays up.
After that, I cannot make my scanner to work even if I run 
".../init.d/usb start".
B.T.W. Did I tell you that I can bring the kernel down just by turning 
the scanner off and then back again?

Confused Roger


