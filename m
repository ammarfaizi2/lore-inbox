Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbVKMVfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbVKMVfz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 16:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbVKMVfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 16:35:55 -0500
Received: from terminus.zytor.com ([192.83.249.54]:52363 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750711AbVKMVfy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 16:35:54 -0500
Message-ID: <4377B1AE.8070806@zytor.com>
Date: Sun, 13 Nov 2005 13:35:42 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
CC: "J.A. Magallon" <jamagallon@able.es>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: x86 building altivec for raid ?
References: <20051113220213.55fc6fae@werewolf.auna.net> <17271.44949.625740.612801@cse.unsw.edu.au>
In-Reply-To: <17271.44949.625740.612801@cse.unsw.edu.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> On Sunday November 13, jamagallon@able.es wrote:
> 
>>Kernel is 2.6.14-mm2.
>>This is an x86 box, why does it compile raid6altivec*.c ? I suppose it
>>does not generate any code, because of some #ifdef magic, but why does
>>it build them anyways ? Looks a bit strange.
> 
> It's probably just easier that way.
> I guess you could do the following, but I'm not sure that it is really
> worth it.
> 

Yes, it's really just simpler.  It ends up being an empty .o file on 
non-altivec machines.

I don't object to changing it, but it doesn't seem worth it to change it.

	-hpa
