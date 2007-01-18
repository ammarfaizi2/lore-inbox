Return-Path: <linux-kernel-owner+w=401wt.eu-S932590AbXARUdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932590AbXARUdy (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 15:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932591AbXARUdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 15:33:53 -0500
Received: from terminus.zytor.com ([192.83.249.54]:33782 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932590AbXARUdx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 15:33:53 -0500
Message-ID: <45AFD9A0.5000408@zytor.com>
Date: Thu, 18 Jan 2007 12:33:36 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
MIME-Version: 1.0
To: Tomasz Chmielewski <mangoo@wpkg.org>
CC: Al Borchers <alb@google.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel cmdline: root=/dev/sdb1,/dev/sda1 "fallback"?
References: <E1H7Uqx-0003X0-0u@llonio.corp.google.com> <45AF827C.4020902@wpkg.org>
In-Reply-To: <45AF827C.4020902@wpkg.org>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Chmielewski wrote:
> Al Borchers wrote:
>> Thomas Chmielewski wrote:
>>> These all unpleasant tasks could be avoided if it was possible to 
>>> have a "fallback" device. For example, consider this hypothetical 
>>> command line:
>>>
>>> root=/dev/sdb1,/dev/sda1
>>
>> Here is a patch to do this, though it sounds like you might have other
>> solutions.
>>
>> This patch is for 2.6.18.1--thanks to Ed Falk for updating my original
>> 2.6.11 patch.  If people are interested I can update and test this on
>> the current kernel.  It was tested on 2.6.11.
> 
> Yes, I'd be interested in a patch against a 2.6.19. It is way simpler to 
> do it this way than to do it with initramfs (although not as flexible).
> 
> I tried your patch against 2.6.19, with some minor changes (as it 
> wouldn't apply), but it didn't work for me (perhaps I just screwed 
> something).
> 

I just might want to point this as an example on the fact that as long 
as the in-kernel mounting code (as opposed to integrated klibc) exists, 
it will want to grow features...

	-hpa

