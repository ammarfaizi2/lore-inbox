Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbUCIWB7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 17:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbUCIWB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 17:01:59 -0500
Received: from fmr06.intel.com ([134.134.136.7]:53732 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262135AbUCIWB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 17:01:56 -0500
Message-ID: <404E3EBB.7030803@linux.co.intel.com>
Date: Tue, 09 Mar 2004 16:01:31 -0600
From: James Ketrenos <jketreno@linux.co.intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: arjanv@redhat.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [Announce] Intel PRO/Wireless 2100 802.11b driver
References: <404E27E6.40200@linux.co.intel.com> <1078865831.4452.16.camel@laptop.fenrus.com>
In-Reply-To: <1078865831.4452.16.camel@laptop.fenrus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> thank you for doing this!
> The driver looks quite good on first inspection too!
> (minor nitpick: please look into request_firmware for the firmware
> loader)

Will do.

I was going down the path of using request_firmware but needed to support older 
2.4 kernels as well, so I punted for the time being and stuck with what you 
currently see.

I hope to add the request_firmware approach soon [ always willing to accept a 
patch :) ]

Also, for those that are interested, we have a mailing list set up for the 
driver at http://lists.sourceforge.net/lists/listinfo/ipw2100-devel.

James
