Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbVI0Ijp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbVI0Ijp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 04:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbVI0Ijp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 04:39:45 -0400
Received: from s0003.shadowconnect.net ([213.239.201.226]:26525 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S964865AbVI0Ijo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 04:39:44 -0400
Message-ID: <4339054A.1000305@shadowconnect.com>
Date: Tue, 27 Sep 2005 10:39:38 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Kay Sievers <kay.sievers@vrfy.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Hannes Reinecke <hare@suse.de>
Subject: Re: [patch 01/28] I2O: remove class interface
References: <20050915070131.813650000.dtor_core@ameritech.net> <20050915070301.943754000.dtor_core@ameritech.net> <20050927000351.GA1219@suse.de>
In-Reply-To: <20050927000351.GA1219@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Greg KH wrote:
> On Thu, Sep 15, 2005 at 02:01:32AM -0500, Dmitry Torokhov wrote:
>>I2O: remove i2o_device_class_interface misuse
>>The intent of class interfaces was to provide different
>>'views' at the same object, not just run some code every
>>time a new class device is registered. Kill interface
>>structure, make class core register default attributes
>>and set up sysfs links right when registering class
>>devices.
>>Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> I've applied this.  I've also cleaned up the class stuff some more and
> converted the drivers/message/i2o/iop.c code to use the easier class and
> class_device interfaces, as you should not have 2 refcounted structures
> trying to control the same overall structure.  The i2o device structure
> is still like this and remains to be fixed up.  If no one does it soon,
> I'll clean it up too.

Could you please wait until i supply the patch, if everyone applies 
patches it's very hard to get those changes and mine together...

And i really don't see that this change is highly critical...

Thank you very much for your understanding...

Best regards,


Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com
