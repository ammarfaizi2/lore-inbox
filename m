Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWBWRzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWBWRzA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 12:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWBWRzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 12:55:00 -0500
Received: from baldrick.bootc.net ([83.142.228.48]:5785 "EHLO
	baldrick.bootc.net") by vger.kernel.org with ESMTP id S932100AbWBWRy7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 12:54:59 -0500
Message-ID: <43FDF6F0.6000006@bootc.net>
Date: Thu, 23 Feb 2006 17:54:56 +0000
From: Chris Boot <bootc@bootc.net>
User-Agent: Mail/News 1.5 (X11/20060114)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: libata PATA drivers patch for 2.6.16-rc4
References: <1140445182.26526.1.camel@localhost.localdomain>	 <43FD347B.6030802@comcast.net> <1140707265.4332.6.camel@localhost.localdomain>
In-Reply-To: <1140707265.4332.6.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mer, 2006-02-22 at 23:05 -0500, Ed Sweetman wrote:
>> With this patch set and the attached config.  Nvidia Nforce4 chipset 
>> from asus A8N-E with pata and sata enabled (no ide drivers) I get the 
>> following error i copied by hand (half assed) during bootup.
>>
>> Process Swapper  "lots of addresses"
> 
> Thanks for all the reports on the oops on boot. I was able to duplicate
> it and fix the dumb bug that caused it.
> 
> New patch (2.6.16-rc4-ide2)
> 
> 	http://zeniv.linux.org.uk/~alan/IDE

-ide2 fixes my boot-time oops as well, cheers.

Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/
