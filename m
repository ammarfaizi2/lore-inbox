Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318735AbSHAMIY>; Thu, 1 Aug 2002 08:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318733AbSHAMH2>; Thu, 1 Aug 2002 08:07:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3338 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318723AbSHAMG7>;
	Thu, 1 Aug 2002 08:06:59 -0400
Message-ID: <3D492531.9030905@mandrakesoft.com>
Date: Thu, 01 Aug 2002 08:10:25 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nico Schottelius <nico-mutt@schottelius.org>
CC: linux.nics@intel.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: network driver informations [general NIC, Wireless and e100]
References: <20020731212426.GA3342@schottelius.org>
X-Enigmail-Version: 0.65.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nico Schottelius wrote:
> Hello!
> 
> I recently tried the e100 driver and was happy that it reports
> if there is a connection and speed and so on.
> 
> But should these informations not be reported through /proc-fs ?
> I think this would make it easier for programs to monitor connection
> status. We could even have a small red/green light in the KDE panel
> to display connection status for different cards.


Thou shalt not add to the junk collection that is procfs :)

Al Viro has talked about, long term, making this information available 
through a filesystem.  When that happens, your request will have 
basically been implemented.

Until then, ioctls :)

	Jeff




