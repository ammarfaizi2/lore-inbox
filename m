Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbWBMThq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbWBMThq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 14:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWBMThq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 14:37:46 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:43057 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S932442AbWBMThp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 14:37:45 -0500
Message-ID: <43F0DFCC.5020404@cfl.rr.com>
Date: Mon, 13 Feb 2006 14:36:44 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Seewer Philippe <philippe.seewer@bfh.ch>, linux-kernel@vger.kernel.org
Subject: Re: RFC: disk geometry via sysfs
References: <43EC8FBA.1080307@bfh.ch> <43F0B484.3060603@cfl.rr.com> <43F0D7AD.8050909@bfh.ch> <Pine.LNX.4.61.0602131410400.17242@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0602131410400.17242@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Feb 2006 19:38:36.0673 (UTC) FILETIME=[15187710:01C630D5]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14265.000
X-TM-AS-Result: No--4.300000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> You can make your own:
>
> Pretend a sector is 512 bytes.
> Use the maximum number of cylinders of either 65535 or 1024
> Use the maximum number of sectors up to 255
> Use the maxumum number of heads up to 255
>
>
> Try the above with 1024 cylinders first. If it doesn't fit, use
> 65535. That's all the BIOS does. It's just used to fit the
> stuff into registers for 16-bit BIOS calls (see int 0x13).
>
>   

Actually, different bioses do it in different ways, that is just one way 
( and possibly the most popular ).  The same bios can even do it 
differently depending on what options are selected in the bios setup.  
Of course, this only effects Microsoft operating systems because 
everyone else is sane and supports LBA. 

