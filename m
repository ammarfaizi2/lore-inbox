Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263264AbTCYTYA>; Tue, 25 Mar 2003 14:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263251AbTCYTXT>; Tue, 25 Mar 2003 14:23:19 -0500
Received: from a089148.adsl.hansenet.de ([213.191.89.148]:56707 "EHLO
	ds666.starfleet") by vger.kernel.org with ESMTP id <S263249AbTCYTWj>;
	Tue, 25 Mar 2003 14:22:39 -0500
Message-ID: <3E80AF19.3010708@portrix.net>
Date: Tue, 25 Mar 2003 20:33:45 +0100
From: Jan Dittmer <j.dittmer@portrix.net>
Organization: portrix.net GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030305
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: Re: add eeprom i2c driver
References: <3E806AC6.30503@portrix.net> <20030325172024.GC15823@kroah.com>
In-Reply-To: <20030325172024.GC15823@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Tue, Mar 25, 2003 at 03:42:14PM +0100, Jan Dittmer wrote:
> 
>>This adds support for reading eeproms.
>>Tested against latest bk changes with i2c-isa.
> 
> 
> I'd like to hold off in submitting the i2c chip drivers just yet, due to
> the changes for sysfs that are going to be needed for these drivers.
> 
> As an example of the changes necessary, here's a patch against the i2c
> cvs version of the eeprom.c driver that converts it over to use sysfs,
> instead of the /proc and sysctl interface.  It's still a bit rough, but
> you should get the idea of where I'm wanting to go with this.  As you
> can see, it takes about 100 lines of code off of this driver, which is
> nice.
> 
> I'm copying the sensors list too, as they wanted to see how this was
> going to be done.
> 
> Comments?
> 

Looks good, I'll try to come up with a converted version of via686a 
later. Should tidy up a lot.

Jan


