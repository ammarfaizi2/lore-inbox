Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbUCUWjO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 17:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbUCUWjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 17:39:14 -0500
Received: from postfix4-1.free.fr ([213.228.0.62]:28903 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S261410AbUCUWjM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 17:39:12 -0500
Message-ID: <405E1993.4050907@free.fr>
Date: Sun, 21 Mar 2004 23:39:15 +0100
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040116
X-Accept-Language: en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.5-rc2-mm1 does not boot. 2.6.5-rc1-mm2 + small fix from axboe
 was fine
References: <405DFA02.8090504@free.fr> <Pine.LNX.4.58.0403211555110.28727@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.58.0403211555110.28727@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> On Sun, 21 Mar 2004, Eric Valette wrote:
> 
>> System starts but hang just before giving hand to init, sometimes I see
>>
>> Mounted devfs on /dev <=== Hangs here
>> Freeing unused kernel memory: 216k freed
>>
>> Sometimes it goes a little bit further but hangs nearly at calling 
>> init...
>>
>> Is there something tagged __init that should not be? Or does some of the
>> new SCSI stuff breaks (swap on sda1, ...).
>>
>> Keyboard still gets interrupt (CAPS lock led), but nothing happens. Like
>> if there was a deadlock. No kdbg...
> 
> 
> How about the following patch?

OK this time, I used the correct original file, applied your patch. But 
it does not help. This time it freeze immediately after :
Freeing unused kernel memory: 216k freed.

Thanks anyway for the suggestion and sorry for the mistake on using the 
wrong version of init/main.c (after partially reverse applying the 
possible incorrect patch).

-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr



