Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262780AbTDRDJm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 23:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262785AbTDRDJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 23:09:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16264 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262780AbTDRDJl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 23:09:41 -0400
Message-ID: <3E9F6F35.2010101@pobox.com>
Date: Thu, 17 Apr 2003 23:21:25 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Marc Wilson <msw@cox.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Via-Rhine dirve in 2.4.21-pre7
References: <1049706637.963.6.camel@athlon> <1050602030.988.4.camel@athlon> <20030417175924.GE25696@gtf.org> <20030418024709.GD14527@moonkingdom.net>
In-Reply-To: <20030418024709.GD14527@moonkingdom.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Wilson wrote:
> On Thu, Apr 17, 2003 at 01:59:24PM -0400, Jeff Garzik wrote:
> 
>>Until further notice, please do not attempt to use Via IOAPIC support.
>>This has nothing to do with via-rhine, and remains an open issue.
> 
> 
> I thought I'd read everything about the Rhine and Via in my lurking on
> lkml, but I must have missed something.  This box here is an Abit KD7-RAID
> (Via KT400 + Rhine II) and I have IOAPIC enabled and am using Roger's latest
> driver with 2.4.21-pre6 with great success.
[...]
> eth0: VIA VT6102 Rhine-II at 0xd800, 00:50:8d:45:af:b7, IRQ 23.
[...]
> What am I missing here?  It sounds like it's dangerous to use, but it
> doesn't look like it's broken.


If it works for you, great!

It doesn't work at all for some people, and it works until you hit high 
loads, for others.  Besides all the bug reports I've seen, Alan Cox has 
noted it's an open issue as well.  He may have more info on the APIC 
details.

Basically there are a lot of "I boot with 'noapic', and suddenly 
everything works" reports.

	Jeff


