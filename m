Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264156AbTE1Tyx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 15:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264850AbTE1Tyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 15:54:53 -0400
Received: from pcp749571pcs.manass01.va.comcast.net ([68.49.125.82]:23168 "EHLO
	charon.int.bittwiddlers.com") by vger.kernel.org with ESMTP
	id S264156AbTE1Tyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 15:54:52 -0400
Date: Wed, 28 May 2003 16:08:01 -0400
To: Gregory Maxwell <greg@xiph.org>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Orinoco_cs module won't unload in 2.5.70
Message-ID: <20030528200755.GA1460@bittwiddlers.com>
References: <20030528154125.GA1289@motherfish-II.xiph.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030528154125.GA1289@motherfish-II.xiph.org>
User-Agent: Mutt/1.5.4i
From: Matthew Harrell <lists-sender-14a37a@bittwiddlers.com>
X-Delivery-Agent: TMDA/0.75 (Ponder)
X-Primary-Address: mharrell@bittwiddlers.com
Reply-To: Matthew Harrell 
	  <mharrell-dated-1054584482.d18b3b@bittwiddlers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Nothing useful.  I've got this problem in a 2.5.65 kernel also.  Really is
annoyying since the machine will not soft reboot because it thinks that
device is still in use.  I have to physically power it off every time I 
want to reboot it change any major pcmcia settings


> Kernel 2.5.70 (and 2.5.69-mm8 before it) on my Dell Latitude C840 is
> unable to unload the orinoco_cs driver.
> 
> I get the following message over and over again while the rmmod hangs:
> unregister_netdevice: waiting for eth1 to become free. Usage count = 1
> 
> Even after ifconfig downing the interface..
> 
> This is quite annoying because the driver doesn't survive suspend and I
> can't cleanly shutdown. :)
> 
> Suggestions?

-- 
  Matthew Harrell                          Artificial Intelligence is no
  Bit Twiddlers, Inc.                       match for natural stupidity
  mharrell@bittwiddlers.com     
