Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310475AbSCPRcx>; Sat, 16 Mar 2002 12:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310474AbSCPRcp>; Sat, 16 Mar 2002 12:32:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57355 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310480AbSCPRc0>;
	Sat, 16 Mar 2002 12:32:26 -0500
Message-ID: <3C93818C.7070207@mandrakesoft.com>
Date: Sat, 16 Mar 2002 12:31:56 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Anders Gustafsson <andersg@0x63.nu>, arjanv@redhat.com,
        linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: [PATCH] devexit fixes in i82092.c
In-Reply-To: <E16mI5y-0006ls-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>If it makes it easier for some, I consider poweroff not as an act unto 
>>itself, but as a transition to state D3cold. :)  And since we will 
>>
>
>That isnt neccessarily a good idea. Not every BIOS is terribly keen when
>faced with a soft boot and someone having powered off all the PCI bridges.
>

s/D3cold/D2bios/ if that's easier to think about :)  I think we can 
apply reboot and poweroff scenarios to the device tree without a 
problem, was the basic point.  It's just another device powerdown state. 
 Instead of powering off the PCI bridge, (random example) we restore the 
PCI bridge settings to exactly the state it was in when the BIOS booted 
the kernel.

    Jeff




