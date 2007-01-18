Return-Path: <linux-kernel-owner+w=401wt.eu-S1752036AbXAROWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036AbXAROWg (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 09:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752041AbXAROWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 09:22:36 -0500
Received: from mail.syneticon.net ([213.239.212.131]:37686 "EHLO
	mail2.syneticon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036AbXAROWf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 09:22:35 -0500
Message-ID: <45AF827C.4020902@wpkg.org>
Date: Thu, 18 Jan 2007 15:21:48 +0100
From: Tomasz Chmielewski <mangoo@wpkg.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061110 Mandriva/1.5.0.8-1mdv2007.1 (2007.1) Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: Al Borchers <alb@google.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel cmdline: root=/dev/sdb1,/dev/sda1 "fallback"?
References: <E1H7Uqx-0003X0-0u@llonio.corp.google.com>
In-Reply-To: <E1H7Uqx-0003X0-0u@llonio.corp.google.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Borchers wrote:
> Thomas Chmielewski wrote:
>> These all unpleasant tasks could be avoided if it was possible to have a 
>> "fallback" device. For example, consider this hypothetical command line:
>>
>> root=/dev/sdb1,/dev/sda1
> 
> Here is a patch to do this, though it sounds like you might have other
> solutions.
> 
> This patch is for 2.6.18.1--thanks to Ed Falk for updating my original
> 2.6.11 patch.  If people are interested I can update and test this on
> the current kernel.  It was tested on 2.6.11.

Yes, I'd be interested in a patch against a 2.6.19. It is way simpler to 
do it this way than to do it with initramfs (although not as flexible).

I tried your patch against 2.6.19, with some minor changes (as it 
wouldn't apply), but it didn't work for me (perhaps I just screwed 
something).


-- 
Tomasz Chmielewski
http://wpkg.org
