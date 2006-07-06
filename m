Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964943AbWGFFgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbWGFFgQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 01:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965168AbWGFFgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 01:36:16 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:30413 "EHLO
	pd2mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S964943AbWGFFgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 01:36:16 -0400
Date: Wed, 05 Jul 2006 23:32:23 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: O_TARGET
In-reply-to: <fa.nsRAsUZV+GPQB1UlyIFSnCjSxYs@ifi.uio.no>
To: yh@bizmail.com.au
Cc: linux-kernel@vger.kernel.org
Message-id: <44ACA067.1020006@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.MfrVuze0cVJi+KUSsOCGQQfE92g@ifi.uio.no>
 <fa.nsRAsUZV+GPQB1UlyIFSnCjSxYs@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yh@bizmail.com.au wrote:
> Thanks Randy, that works. But now it generated a NewSerial.ko instead of
> NewSerial.o in kernel 2.6, this caused a problem when I called the insmod,
> the insmod added another .o as follows:
> 
> insmod NewSerial.ko
> insmod: NewSerial.ko.o: no module by that name found
> 
> Is it possible for me to get a NewSerial.o, not a NewSerail.ko?

.ko is what modules are in 2.6, are you using some old version of the 
module utilities?

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

