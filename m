Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbWCWSdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbWCWSdm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 13:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbWCWSdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 13:33:42 -0500
Received: from w3.zipcon.net ([209.221.136.4]:61099 "HELO w3.zipcon.net")
	by vger.kernel.org with SMTP id S932427AbWCWSdl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 13:33:41 -0500
Message-ID: <4422E9FC.8060303@beezmo.com>
Date: Thu, 23 Mar 2006 10:33:32 -0800
From: William D Waddington <william.waddington@beezmo.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFCLUE2] 64 bit driver 32 bit app ioctl
References: <4422B95D.9070900@beezmo.com> <1143132597.3147.31.camel@laptopd505.fenrus.org>
In-Reply-To: <1143132597.3147.31.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Thu, 2006-03-23 at 07:06 -0800, William D Waddington wrote:
> 
>>Apologies for dashing this off without the proper homework.  My
>>customer is out of country doing an installation, and didn't test
>>this configuration first :(
>>
>>Customer is running RHEL3 on a 64 bit PC.  Running the 64 bit kernel
>>and my 64 bit driver.  They are calling the driver from their 32 bit
>>app.  The driver supports a whole mess of ioctls.
>>
>>It seems that the kernel is trapping the 32-bit ioctl call and returning
>>an error to the app w/out calling the driver.  It looks like
>>register_ioctl32_conversion() can convice the kernel that the driver can
>>handle 32-bit calls, but it has to be called for each ioctl cmd (??)
> 
> 
> you forgot to attach you code btw or post the url to it..

No I didn't :) It's just too ugly for public view.  And I notice it
needs some other fix-ups like fixed width data types in the ioctl
routine...

Thanks to all for the info.  I've got some typing to do.

Bill

