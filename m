Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271369AbTHHO3d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 10:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271367AbTHHO3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 10:29:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28588 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S271369AbTHHO31
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 10:29:27 -0400
Message-ID: <3F33B3B9.7030905@pobox.com>
Date: Fri, 08 Aug 2003 10:29:13 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Watts <m.watts@eris.qinetiq.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Innovision EIO DM-8301H/R SATA cards...
References: <200308081408.16564.m.watts@eris.qinetiq.com> <3F33A3EB.9030108@pobox.com> <200308081511.28238.m.watts@eris.qinetiq.com>
In-Reply-To: <200308081511.28238.m.watts@eris.qinetiq.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Watts wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> 
>>Mark Watts wrote:
>>
>>>-----BEGIN PGP SIGNED MESSAGE-----
>>>Hash: SHA1
>>>
>>>
>>>My local supplier has started doing some SATA cards....
>>>
>>>http://www.ivmm.com/eio/products_sata_pci_host.html
>>>
>>>
>>>The chip on the board i the screenshot looks vaguely like a Silicon Image
>>>chip - - am I correct in thinking that these are supported in linux?
>>
>>If they are Silicon Image, yes, they are supported.
> 
> 
> Great stuff - can someone confirm whether I still need to do the folloing for 
> the latest 2.4.22 kernels in order to get good performance?
> 
> # hdparm -d1 -X66 /dev/hdX
> # echo "max_kb_per_request:15" > /proc/.ide/hdX/settings


I have no idea :(   I'm off in libata land, which will soon support 
Silicon Image SATA as well...

	Jeff



