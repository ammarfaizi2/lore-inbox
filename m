Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263785AbTETOAa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 10:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263787AbTETOAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 10:00:30 -0400
Received: from ip-66-80-37-197.chi.megapath.net ([66.80.37.197]:32772 "HELO
	srvr1.mousebusiness.com") by vger.kernel.org with SMTP
	id S263785AbTETOA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 10:00:29 -0400
Message-ID: <20030520141152.5916.qmail@srvr1.mousebusiness.com>
From: "kernel" <kernel@mousebusiness.com>
To: linux-kernel@vger.kernel.org
Subject: Promise SX6000 No handler for event (fwd)
Date: Tue, 20 May 2003 09:11:52 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes: 

>> May 19 13:05:59 production kernel: i2o/iop0: No handler for event 
>> (0x00000020)
>> May 19 13:05:59 production kernel: i2o/iop0: No handler for event 
>> (0x00000020)
> 
> It sent us two event messages for events we've never head of (or asked
> for)
If we never asked for these messages, why did it send them? 

> 
>> May 19 13:06:04 production kernel: i2o/iop0: Hardware Failure: Unknown Error
> 
> and then exploded  
> 
Yep. That's what's happening. Now, how do I defuse it? I *think* I'm setting 
this up just as suggested on this list and various other sources, yet still 
it is a no-go. 

Btw. I got those error messages while trying to copy data from an 
NFS-mounted volume from an old, slow, busy server to my RAID. This tells me 
that probably the errors aren't caused by the SX6000 getting floodded by 
incoming data stream and not being able to keep up with it. 
