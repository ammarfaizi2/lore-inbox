Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293397AbSB1MbK>; Thu, 28 Feb 2002 07:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293395AbSB1M2t>; Thu, 28 Feb 2002 07:28:49 -0500
Received: from [195.63.194.11] ([195.63.194.11]:30986 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S293347AbSB1M17>; Thu, 28 Feb 2002 07:27:59 -0500
Message-ID: <3C7E2214.3030201@evision-ventures.com>
Date: Thu, 28 Feb 2002 13:27:00 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andre Hedrick <andre@linuxdiskcert.org>
CC: Tim Moore <timothymoore@bigfoot.com>, linux-kernel@vger.kernel.org
Subject: Re: disk transfer speed problem
In-Reply-To: <Pine.LNX.4.10.10202272049180.22351-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> What is more useful is the cat /proc/ide/ide0/config !!!
> 
>>From that I can tell you what is going on completely about the system.
> 
> Oh and for those not reading this email, it is a side note on why the ide
> proc-pci interface had best be left alone and in tact. 

Module the fact fact lspci could be easly extendid to provide the
same information from user space... wait... we are on unix and we have
manual pages:

        -x     Show hexadecimal dump of first 64 bytes of the  PCI
               configuration  space  (the standard header). Useful
               for debugging of drivers and lspci itself.

        -xxx   Show hexadecimal dump of  whole  PCI  configuration
               space.  Available  only  for  root  as  several PCI
               devices crash when you try to read  undefined  por-
               tions  of the config space (this behaviour probably
               doesn't violate the PCI standard, but it's at least
               very stupid).

As you can see lspci -x -xxx ALREADY DOES THIS!

