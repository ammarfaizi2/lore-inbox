Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966058AbWKIVL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966058AbWKIVL7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 16:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966064AbWKIVL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 16:11:59 -0500
Received: from kilderkin.sout.netline.net.uk ([213.40.66.40]:24575 "EHLO
	kilderkin.sout.netline.net.uk") by vger.kernel.org with ESMTP
	id S966062AbWKIVL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 16:11:58 -0500
Message-ID: <45539991.1090105@supanet.com>
Date: Thu, 09 Nov 2006 21:11:45 +0000
From: Andrew Benton <b3nt@supanet.com>
User-Agent: Thunderbird 3.0a1 (X11/20061109)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: pingc@wacom.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Typo in drivers/usb/input/wacom_wac.c?
References: <4551A981.60709@supanet.com> <20061108151907.GA21450@kroah.com>
In-Reply-To: <20061108151907.GA21450@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Supanet-AV-out: Mail Scanned as virus free, although you should still use a local virus scanner.
X-Supanet: This was sent via a www.supanet.com mail server
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Wed, Nov 08, 2006 at 09:55:13AM +0000, Andrew Benton wrote:
>> Hello World,
>> my Wacom Volito2 tablet doesn't work with the kernel driver as it is. 
>> The cursor jitters about at the bottom of the screen in a useless 
>> manner. However, if I edit drivers/usb/input/wacom_wac.c and change the 
>> two instances of wacom_be16_to_cpu to wacom_le16_to_cpu then it works 
>> perfectly
>>
>> sed -i 's/_b/_l/' drivers/usb/input/wacom_wac.c
> 
> Which kernel version are you referring to?

2.6.19-rc5

Andy

