Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265132AbTLFMYh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 07:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265133AbTLFMYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 07:24:37 -0500
Received: from pop.gmx.net ([213.165.64.20]:30429 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265132AbTLFMYg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 07:24:36 -0500
X-Authenticated: #4512188
Message-ID: <3FD1CA81.9010708@gmx.de>
Date: Sat, 06 Dec 2003 13:24:33 +0100
From: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031116
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: cheuche+lkml@free.fr
CC: linux-kernel@vger.kernel.org
Subject: Re: Catching NForce2 lockup with NMI watchdog - found
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F87E@mail-sc-6.nvidia.com> <3FD1199E.2030402@gmx.de> <20031206081848.GA4023@localnet>
In-Reply-To: <20031206081848.GA4023@localnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cheuche+lkml@free.fr wrote:
> On Sat, Dec 06, 2003 at 12:49:50AM +0100, Prakash K. Cheemplavam wrote:
> 
>>So gals and guys, try disabling cpu disconnect in bios and see whether 
>>aopic now runs stable.
>>
> 
> Yes that fix it. Well time will tell but I cannot make it crash with
> hdparm -tT or cat /dev/hda so far. I'm dumping hda to /dev/null right
> now.
> 
> After testing to make it crash, I used athcool to reenable CPU
> disconnect, and guess what, test after that just crashed the box.
> You found the problem, congratulations.

:-)

Isn't it possible to ad athcool's code into the kernel, maybe into the 
pm section or even make it an kernel option. It seems to be a nice 
workaround for the time-being.

Prakash

