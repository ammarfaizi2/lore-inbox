Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267251AbUHMTXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267251AbUHMTXH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 15:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266916AbUHMTXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 15:23:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50396 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267264AbUHMTSu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 15:18:50 -0400
Message-ID: <411D140C.4040100@pobox.com>
Date: Fri, 13 Aug 2004 15:18:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Arjan van de Ven <arjanv@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Alan Cox <alan@www.pagan.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SG_IO and security
References: <1092313030.21978.34.camel@localhost.localdomain> <Pine.LNX.4.58.0408120929360.1839@ppc970.osdl.org> <Pine.LNX.4.58.0408120943210.1839@ppc970.osdl.org> <1092341803.22458.37.camel@localhost.localdomain> <Pine.LNX.4.58.0408121705050.1839@ppc970.osdl.org> <20040813065902.GB2321@suse.de> <1092383006.2813.0.camel@laptop.fenrus.com> <20040813074654.GA2663@suse.de>
In-Reply-To: <20040813074654.GA2663@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Fri, Aug 13 2004, Arjan van de Ven wrote:
> 
>>>While that does make sense, it would be more code to fold them together
>>>than what is currently there. SCSI_IOCTL_SEND_COMMAND is really
>>>horrible, the person inventing that API should be subject to daily
>>>public ridicule.
>>
>>sounds like deprecation of this interface should start (I suspect this
> 
> 
> Very much so, it should have been deprecated for the last 5 years :)
> 
> 
>>one will need ample notice of that so the sooner we do .... )
> 
> 
> I have no idea how many apps use this ioctl, does anyone have a rough
> list?


Add a rate-limited "this feature is deprecated" feature and find out...

	Jeff


