Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbTJFOhV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 10:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTJFOhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 10:37:21 -0400
Received: from as1-2-5.han.s.bonet.se ([194.236.155.59]:42249 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S262104AbTJFOhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 10:37:20 -0400
Message-ID: <3F817E1F.9000201@2gen.com>
Date: Mon, 06 Oct 2003 16:37:19 +0200
From: =?ISO-8859-1?Q?David_H=E4rdeman?= <david@2gen.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030925 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Broadcom BCM5901 NIC
References: <20030927231904.GA22769@hardeman.nu> <3F761D02.3050708@pobox.com>
In-Reply-To: <3F761D02.3050708@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> David Härdeman wrote:
>
>> Broadcom has released a driver of their own (bcm5700) which works 
>> with kernel 2.4.21. When I try that combination it works fine, 
>> however, the bcm5700 driver wont work at all on recent 2.4 or 2.6 
>> kernels.
>>
>> Does anyone know what is wrong with the tg3 driver? Has anyone tried 
>> using it on a 5901 card with success?
>
> Trying unplugging/plugging the cable, or ifdown+ifup cycle, and let me 
> know if that fixes things.
>
>     Jeff
>
Hi,

an update from the time I posted the previous message:

1) Broadcom has since released a 7.0.0 version of their driver, it works 
just fine with the latest 2.6 kernels (tried it on 2.6.0-test6 and using 
it right now on 2.6.0-test6-mm4).

2) The in-kernel tg3 driver still doesn't work with the Broadcom 5901 
NIC (tried with 2.6.0-test6 and 2.6.0-test6-mm4). Same symptoms as 
previously (card is found and appears as eth0, but no traffic is 
sent/recieved by the card).

3) I've asked around on a few lists (debian-user, debian-laptop-user and 
linux-thinkpad) but been unable to find any G40 owner that has tried the 
tg3 driver with their NIC. It seems that all of them are using the 
bcm5700 driver which would explain the lack of other bug reports. Are 
there any G40 owners on this list who would be willing to test if the 
tg3 driver in the latest kernels work with their NIC's?

Kind regards,
David


