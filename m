Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbUANRrB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 12:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbUANRrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 12:47:01 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:22505 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261877AbUANRq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 12:46:59 -0500
Message-ID: <40058086.5000106@nortelnetworks.com>
Date: Wed, 14 Jan 2004 12:46:46 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Nuno Silva <nuno.silva@vgertech.com>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 013 release
References: <20040113235213.GA7659@kroah.com> <4004D084.1050106@vgertech.com> <20040114171527.GB5472@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Wed, Jan 14, 2004 at 05:15:48AM +0000, Nuno Silva wrote:

>>A sugestion and a question:
>>
>>- Make udev print a /etc/udev/udev.rules line every time a device is 
>>found because default behaviour is too silent and "make DEBUG=true" is 
>>too noisy.

> Yeah, but what exactly would udev print out?  All of the sysfs files in
> the device it found?  Would it print it out for every device that comes
> through?  Or just for ones that no rule applied to?


Maybe for ones with a matching rule, you could print something like:

udev[1234]: new device found matching rule <blah>, creating device node 
<nodename>

For ones that don't match any rules, you could dump out all the info:

udev[1234]: new device found with no matching rules, device info: blah blah



Chris




-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

