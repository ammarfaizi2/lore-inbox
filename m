Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265872AbUALAsk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 19:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265875AbUALAsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 19:48:40 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:5449 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S265872AbUALAsi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 19:48:38 -0500
Message-ID: <4001EED8.1000908@samwel.tk>
Date: Mon, 12 Jan 2004 01:48:24 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Tim Cambrant <tim@cambrant.com>, Mario Vanoni <vanonim@bluewin.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][TRIVIAL] Remove bogus "value 0x37ffffff truncated to
 0x37ffffff" warning.
References: <Pine.LNX.4.44.0401110852030.19685-100000@bigblue.dev.mdolabs.com>
In-Reply-To: <Pine.LNX.4.44.0401110852030.19685-100000@bigblue.dev.mdolabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
>>Now it seems to behave correctly: for '~' it always warns, for '-' it 
>>only warns if the negative value is below -0x80000000. I'll submit a 
>>patch to this effect (including the format extensions) to the binutils 
>>people.
> 
> binutils 2.14 works fine, so I believe they already fixed it.

Against your code, yes. I'm using binutils 2.14 as well. Check it when 
declaring a .long, like the kernel code does. Then it warns.

-- Bart
