Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263240AbUDMFQa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 01:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263348AbUDMFQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 01:16:30 -0400
Received: from web02-imail.bloor.is.net.cable.rogers.com ([66.185.86.76]:59370
	"EHLO web02-imail.rogers.com") by vger.kernel.org with ESMTP
	id S263240AbUDMFQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 01:16:28 -0400
From: "Shawn Starr" <shawn.starr@rogers.com>
To: "'Jeff Garzik'" <jgarzik@pobox.com>
Cc: "'Len Brown'" <len.brown@intel.com>, <linux-kernel@vger.kernel.org>,
       <netdev@oss.sgi.com>
Subject: RE: [BUG][2.6.5 final][e100/ee100pro] NETDEV_WATCHDOG Timeout -Related to i2c interface?
Date: Tue, 13 Apr 2004 01:16:33 -0400
Message-ID: <000001c42116$7d00fb70$0200080a@panic>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
In-Reply-To: <4079B246.4070107@pobox.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at web02-imail.rogers.com from [69.196.108.95] using ID <shawn.starr@rogers.com> at Tue, 13 Apr 2004 01:15:38 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Might be, I have since not had any issues with timeouts. Though, I don't
know where it is doing this. It is an IBM machine so some things are
proprietary.

-----Original Message-----
From: Jeff Garzik 
Sent: Sunday, April 11, 2004 05:02 PM
To: Shawn Starr
Cc: 'Len Brown'; linux-kernel@; netdev@
Subject: Re: [BUG][2.6.5 final][e100/ee100pro] NETDEV_WATCHDOG Timeout
-Related to i2c interface?


Shawn Starr wrote:
> Ok, this is strange, I put in an external 10/100 PRO S Adaptor, and im 
> not getting anymore eth0 timeouts, I would only get eth0 timeouts on 
> the ONBOARD nic if I enabled the lm80 sensor driver.. I don't know 
> what to say, the onboard nic would work fine without lm80 being 
> loaded?
> 
> Is there some sort of race condition that the onboard 10/100 PRO is 
> doing ?

If i2c is killing the network, sounds like it's diddling something on 
the motherboard it shouldn't...

	Jeff





