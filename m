Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268962AbUHMETq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268962AbUHMETq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 00:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268963AbUHMETq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 00:19:46 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:6655 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S268962AbUHMETp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 00:19:45 -0400
Message-ID: <411C4130.4000303@comcast.net>
Date: Fri, 13 Aug 2004 00:18:56 -0400
From: Clem Taylor <clemtaylor@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Any news on a higher performance sata_sil SIL_QUIRK_MOD15WRITE
 workaround?
References: <411AFD2C.5060701@comcast.net> <411B118B.4040802@pobox.com>
In-Reply-To: <411B118B.4040802@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Get a different controller + disk combination.

I don't want to dump the disks, but I may be ordering a 3ware controller 
in the near future. The only reason I didn't get a 3ware controller in 
the first place was that the Sil 3114 was on the motherboard.

> The problem is that the Silicon Image controller sends unusual -- but 
> legal -- block sizes to the SATA device.
> 
> Older Seagates cannot cope with this unique, but spec-correct behavior.

I thought that the Seagate ST3160023AS was a fairly new drive. I noticed 
a comment that version 3.18 of the firmware may not suffer from this 
problem, can anyone confirm this? I'm going to try removing my drive 
from the blacklist and see what happens.

>> It would seem that the root of the problem is a Seagate issue. Does 
>> anyone know if Seagate fixed the problem with a firmware update? 
> 
> You could find out for us, and let us know :)

I tried, my contact at Seagate doesn't seem to be with them anymore (I 
haven't worked in the storage space in quite some time).

                 Thanks for the help,
                 Clem
