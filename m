Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbUDKVCO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 17:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbUDKVCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 17:02:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28380 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262476AbUDKVCN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 17:02:13 -0400
Message-ID: <4079B246.4070107@pobox.com>
Date: Sun, 11 Apr 2004 17:01:58 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shawn Starr <shawn.starr@rogers.com>
CC: "'Len Brown'" <len.brown@intel.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [BUG][2.6.5 final][e100/ee100pro] NETDEV_WATCHDOG Timeout -Related
 to i2c interface?
References: <000001c42000$dd6e78f0$0200080a@panic>
In-Reply-To: <000001c42000$dd6e78f0$0200080a@panic>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn Starr wrote:
> Ok, this is strange, I put in an external 10/100 PRO S Adaptor, and im not
> getting anymore eth0 timeouts, I would only get eth0 timeouts on the ONBOARD
> nic if I enabled the lm80 sensor driver.. I don't know what to say, the
> onboard nic would work fine without lm80 being loaded?
> 
> Is there some sort of race condition that the onboard 10/100 PRO is doing ?

If i2c is killing the network, sounds like it's diddling something on 
the motherboard it shouldn't...

	Jeff




