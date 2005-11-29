Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbVK2GRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbVK2GRH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 01:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbVK2GRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 01:17:07 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:53438 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751320AbVK2GRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 01:17:06 -0500
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Transfer-Encoding: 7bit
Message-Id: <49AF82E8-C8DA-458C-B66E-187DC1650AC8@comcast.net>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: linux-kernel <linux-kernel@vger.kernel.org>
From: Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: PowerBook5,8 - TrackPad update
Date: Tue, 29 Nov 2005 01:17:04 -0500
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 28, 2005, at 7:06 PM, Michael Hanselmann wrote:

> The product ID I have, 0x0215, was in none of the
> available drivers and the data format is somewhat different

Hi Michael

Is yours the 15" model or the 17"? Mine is 15" and the product id is  
0x0214.

> You find my hacked version attached -- be aware that in its current  
> form
> it will not work with any touchpad except 0x0215.

I haven't looked at your changes completely yet but are you saying it  
works? Meaning mouse
moves properly?

Also I find it strange that your model requires 80 bytes ATP_DATASIZE  
- mine isn't happy
at all with anything less than 256. The less number of sensors you  
defined is again a puzzle.

> As far as I see it, all methods can be built into one driver. Is there
> already someone working on combining them?

If the format of the data is same (which looks like it is with your  
model) then yes, but in my case
the data arrives is 64 byte blocks - there are 4 of them in one  
transfer, each a reading on it's own.

Hmm. More confusion.

Thanks

Parag
