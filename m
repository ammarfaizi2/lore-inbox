Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261809AbSIXU7h>; Tue, 24 Sep 2002 16:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261810AbSIXU7h>; Tue, 24 Sep 2002 16:59:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16912 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261809AbSIXU7g>;
	Tue, 24 Sep 2002 16:59:36 -0400
Message-ID: <3D90D34F.3060903@pobox.com>
Date: Tue, 24 Sep 2002 17:04:15 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Daniel E. F. Stekloff" <dsteklof@us.ibm.com>
CC: Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       cgl_discussion mailing list <cgl_discussion@osdl.org>,
       evlog mailing list <evlog-developers@lists.sourceforge.net>,
       "ipslinux (Keith Mitchell)" <ipslinux@us.ibm.com>,
       Linus Torvalds <torvalds@home.transmeta.com>,
       Hien Nguyen <hien@us.ibm.com>, James Keniston <kenistoj@us.ibm.com>,
       Mike Sullivan <sullivam@us.ibm.com>
Subject: Re: [evlog-dev] alternate event logging proposal
References: <20020924073051.363D92C1A7@lists.samba.org> <3D90C183.5020806@pobox.com> <200209241354.38013.dsteklof@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel E. F. Stekloff wrote:
> I agree with you that there needs to be a strategy for what is logged by a 
> driver and how it is logged. We believe log analysis is an essential part of 
> diagnosing errors. Log messages, when generated consistently, could indicate 
> what drivers were loaded, when they were loaded, what their current version 
> is, and what errors they have encountered. How the messages are formatted, 
> whether they follow certain rules, can greatly aid User Space diagnostic 
> applications. 
> 
> We propose standardizing what should be logged and how those log messages 
> should look.

[snip]

> Any comments?


I agree with the generalities... I am looking for something far more 
specific, though.

My point in the second half of my proposal message was trying to drive 
home the point that IBM doesn't appear to know, at this time, what the 
diagnostic messages the 8139too net driver should output.  Or the 
aic7xxxx scsi driver.  Or the piix ATA driver.

And until IBM knows those things, I cannot see how any proposal can be 
put forward.  _what data_ should be logged?  "useful data" is not an 
answer.  "eeprom checksum failure, with failed checksum value" is an 
answer.  If IBM does not know these things, it is putting forward a 
solution when the problem has not clearly been examined or even defined.

I want all my net drivers to log useful data.  I also want world peace. 
  The devil is in the details.

	Jeff



