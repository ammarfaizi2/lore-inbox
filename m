Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbTEHVbi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 17:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262140AbTEHVba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 17:31:30 -0400
Received: from zeke.inet.com ([199.171.211.198]:47581 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id S262138AbTEHVb1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 17:31:27 -0400
Message-ID: <3EBACF9D.5070501@inet.com>
Date: Thu, 08 May 2003 16:43:57 -0500
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jt@hpl.hp.com
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: The magical mystical changing ethernet interface order
References: <20030508193245.GA26721@bougret.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes wrote:
[snip]
> Randy.Dunlap wrote :
> 
>>An alternative is to use 'nameif' to associate MAC addresses with
>>interface names.  See here for mini HOWTO:
>>
>>  http://www.xenotime.net/linux/doc/network-interface-names.txt
> 
> 
> 	Currently this feels like a kludge, because not fully
> inegrated, but goes in the right direction.
> 	Actually, it's pretty funny that the original Pcmcia package
> got it right since the beggining (and Win2k as well), but
> distributions took a step backward from that when integrating Pcmcia.
> 	My belief is that configuration scripts should be specified in
> term of MAC address (or subset) and not in term of device name. Just
> like the Pcmcia scripts are doing it.
> 	And let's go the extra mile : ifconfig should accept a MAC
> address as the argument instead of a device name. And in the long
> term, just get rid of device name from the user view.

Some network devices do not have a mac address on power-up and must be 
supplied one.

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

