Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbTKOUlV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 15:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbTKOUlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 15:41:21 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56292 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262070AbTKOUlU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 15:41:20 -0500
Message-ID: <3FB68F59.1050909@pobox.com>
Date: Sat, 15 Nov 2003 15:40:57 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: azarah@nosferatu.za.org
CC: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: Carrier detection for network interfaces
References: <1068912989.5033.32.camel@nosferatu.lan>	 <3FB652BA.1010905@pobox.com> <1068928120.5033.34.camel@nosferatu.lan>
In-Reply-To: <1068928120.5033.34.camel@nosferatu.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schlemmer wrote:
> On Sat, 2003-11-15 at 18:22, Jeff Garzik wrote:
> 
>>Martin Schlemmer wrote:
>>
>>>Is there any proper way to detect a carrier signal with network
>>>interfaces ?  I have recently come across a problem where we tried
>>>to do with with checking for 'RUNNING', which do not work for all
>>>drivers, as well as mii-tool that fails in some cases.
>>
>>
>>What kernel version?
>>
>>In 2.6 you have linkwatch.  In 2.4 and 2.6, you have ETHTOOL_GLINK, and 
>>mii-tool.
>>
> 
> 
> Anything more shell accessible (sysfs/proc) ?


ethtool is shell accessible.

	Jeff



