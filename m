Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274991AbTHATyM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 15:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274990AbTHATyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 15:54:11 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:30798 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S274982AbTHATxU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 15:53:20 -0400
Message-ID: <3F2AC3DA.6040901@rackable.com>
Date: Fri, 01 Aug 2003 12:47:38 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre10 compile failure  USB HID
References: <3F2AC00C.1010203@rackable.com> <20030801194406.GA31510@kroah.com>
In-Reply-To: <20030801194406.GA31510@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Aug 2003 19:53:18.0766 (UTC) FILETIME=[8DEEECE0:01C35866]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Fri, Aug 01, 2003 at 12:31:24PM -0700, Samuel Flory wrote:
>  
>
>> I'm seeing a linking issue when I compile USB HID support directly 
>>into the kernel.  Looking at my kernel config it looks like it might 
>>have something to do with the fact that I'm compiling CONFIG_INPUT, 
>>CONFIG_INPUT_KEYBDEV, and CONFIG_INPUT_MOUSEDEV as modules.  Should 
>>CONFIG_USB_HID depend on one, or all of the above.
>>    
>>
>
>Yes, that configuration will not work.  I think this has been discussed
>many times on the lists in the past, and the end agreement is, "Don't
>try to do that." :)
>
>It's not an easy configuration language fix from what I remember.
>
>  
>

  I'll take a look it.  It seems to work if you compile in the rest of 
the HID stuff.

-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


