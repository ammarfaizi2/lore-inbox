Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267089AbUBMQNp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 11:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267094AbUBMQNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 11:13:45 -0500
Received: from gw-nl4.philips.com ([161.85.127.50]:20881 "EHLO
	gw-nl4.philips.com") by vger.kernel.org with ESMTP id S267089AbUBMQNW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 11:13:22 -0500
Message-ID: <402CF851.2000707@basmevissen.nl>
Date: Fri, 13 Feb 2004 17:16:17 +0100
From: Bas Mevissen <ml@basmevissen.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Simon Oosthoek <simon@ti-wmc.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem EIP + kernel panic
References: <200402120105.33222.egan@club-internet.fr> <c0i5bk$src$1@sea.gmane.org>
In-Reply-To: <c0i5bk$src$1@sea.gmane.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Oosthoek wrote:

> Emmanuel Gaudin wrote:
> 
>> Hi everybody , and sorry for my english.
>>
>> I am under debian sid and i have installed the kernel 2.424 . After 
>> few time i
>> noticed that the new kernel-image on the debian apt tree was 
>> available. So i
>> decidede to install it. (For the 2.4.24 i did with the kernel sources and
>> make dep etc..) I have installed it then i reboot.
>> On the reboot i have a kernel panic due to a eip problem.
>> My mother board is a p4p800 and the kernel version i've installed is the
>> 2.6.2-smp. (i have a 2.6 ghz intel cpu with hyperthreading.)
>>
>> Have someone an idea?
> 
> 
> Try booting with kernel parameter pnpbios=off, it's a problem with the
> pnp implementation of the intel 8(6?/7)5 chipset. (a bios upgrade to P18
> didn't help for me, I don't know if recent changes in 2.6.3-... address
> this issue)
> 

AFAIK, it is not fixed yet.

> I may not be the best person to answer this, I just know this is the
> problem ;-)
> 

Correct. See messages with subject "2.6 kernel boot crashing" too.

I own the same motherboard and got the same problems. Doing what you 
suggest will let the problem go away.

Bas.


