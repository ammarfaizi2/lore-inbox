Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265291AbTFZBOX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 21:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265325AbTFZBOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 21:14:23 -0400
Received: from relay1.enom.com ([66.150.5.205]:42251 "EHLO Relay1.enom.com")
	by vger.kernel.org with ESMTP id S265291AbTFZBOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 21:14:22 -0400
Message-ID: <20030625182834-050000041>
Message-ID: <3EFA4C3D.5040506@homemail.com>
Date: Thu, 26 Jun 2003 11:28:29 +1000
From: "D. Sen" <dsen@homemail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030425
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Scott McDermott <vaxerdec@frontiernet.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: ide-scsi on 2.4.21 (on IBM Thinkpad T30)
References: <3EF753EC.9080807@homemail.com> <3EFA2B83.3090305@homemail.com> <20030625193829.M9583@newbox.localdomain> <20030625163936-113600041>
In-Reply-To: <20030625163936-113600041>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Jun 2003 01:28:34.0272 (UTC) FILETIME=[426CCE00:01C33B82]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think you are saying that its not a module. Here is another report of 
a similar problem to mine:

http://www.music.columbia.edu/pipermail/linux-audio-user/2003-June/005119.html

He eventually solved the problem by making sure the ssci support wasnt 
built as modules. (Follow the thread above).

There definitely seems to be a problem. If its not a problem but rather 
a feature then I would like to know more about why we need to compile it 
into the kernel...(i.e. what do we gain )..

Scott McDermott wrote:
> whoops forgot to add you to CC list as per your request
> 
> To linux-kernel@vger.kernel.org on Wed 25/06 19:38 -0400:
> 
>>D. Sen on Thu 26/06 09:08 +1000:
>>
>>>>>Kernel 2.4.21 causes hangs and/or ooops during boot up
>>>>>if I have a "probeall scsi_hostadapter ide-scsi" in my
>>>>>/etc/modules.conf. If I take out that line and
>>>>>manually load the module after the laptop has booted,
>>>>>everything is fine.
>>>>
>>>>I probably have the same CD-RW that you do (in the T30)
>>>>and I just use hdc=ide-scsi on kernel command line, no
>>>>need for manually loading. Works fine but don't try
>>>>burning with magicdev running :)
>>>
>>>Do you have ide-scsi built as a module though?
>>
>>Yes.  It works fine, I just tried with cdrdao using
>>generic-mmc driver.  I have nothing at all in modules.conf
>>related to cd, ide, or scsi.
> 
> 
> 



