Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbVFBVjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVFBVjs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 17:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbVFBUJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 16:09:18 -0400
Received: from relay1.tiscali.de ([62.26.116.129]:33701 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S261289AbVFBTnU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 15:43:20 -0400
Message-ID: <429F6162.2080608@tiscali.de>
Date: Thu, 02 Jun 2005 21:43:30 +0200
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grzegorz Kulewski <kangur@polcom.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: IA32 | [OFFTOPIC]: Segementation Question
References: <429F58CD.4020505@tiscali.de> <Pine.LNX.4.63.0506022115370.14006@alpha.polcom.net>
In-Reply-To: <Pine.LNX.4.63.0506022115370.14006@alpha.polcom.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grzegorz Kulewski wrote:
> On Thu, 2 Jun 2005, Matthias-Christian Ott wrote:
> 
>> Hi.
>> I'm currently doing some research on the IA32 Segementation Concept. 
>> But there's one thing I don't understand:
>> If I perform a far jump it looks like this:
>> jmp    16bit:32bit
>>
>> The 16bit are representing the segement number and the 32bit the 
>> offset. But to what refers the 16bit? To the GDT or the current LDT?
> 
> 
> IIRC, there is one bit flag in selector that decides if it is from GDT 
> or LDT. But maybe I am wrong...
> 
> 
> Grzegorz Kulewski
> 
Ok, you're right, I read over this (see IA-32 Manual Part 3, Page 81).

--
Matthias-Christian Ott
