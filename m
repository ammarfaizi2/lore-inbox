Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbWIOAvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWIOAvo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 20:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWIOAvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 20:51:44 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:43158 "EHLO
	pd3mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751137AbWIOAvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 20:51:43 -0400
Date: Thu, 14 Sep 2006 18:51:03 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [linux-usb-devel] 2.6.18-rc6-mm1 (-mm2): ohci resume problem
In-reply-to: <fa.d7LE5j2KeqaUO4bsZpo8y9R4gYc@ifi.uio.no>
To: Alan Stern <stern@rowland.harvard.edu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Message-id: <4509F8F7.1050901@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.CoF5TlzZuzrQVRlWotoenffiTfo@ifi.uio.no>
 <fa.d7LE5j2KeqaUO4bsZpo8y9R4gYc@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote:
> On Thu, 14 Sep 2006, Alan Stern wrote:
> 
>> Now of course, the autosuspend stuff has to work properly no matter what 
>> the kernel configuration is.  I'll go back and rebuild the drivers with 
>> USB_SUSPEND turned off and see what happens.  With any luck I'll have a 
>> fix ready in the near future.
> 
> This should start fixing things, but I'm not certain it will solve the 
> entire problem.  If it doesn't work, send another dmesg log.

This patch seems to fix the problem for me..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

