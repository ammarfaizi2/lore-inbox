Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161062AbWI3BYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161062AbWI3BYw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 21:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161066AbWI3BYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 21:24:52 -0400
Received: from ns2.lanforge.com ([66.165.47.211]:61645 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S1161062AbWI3BYv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 21:24:51 -0400
Message-ID: <451DC75E.4070403@candelatech.com>
Date: Fri, 29 Sep 2006 18:24:46 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: khc@pm.waw.pl
Subject: Question on HDLC and raw access to T1/E1 serial streams.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am looking for a way to bridge a T1/E1 network by reading a raw 
bitstream from one T1 interface and writing it out to the other.  The 
application is adding delay and/or bit corruptions for impairment testing.

I have been using Sangoma's drivers and NICs, but I'm having no luck 
getting their latest stuff to work so I was hoping to use in-kernel
drivers (even if that means writing or hiring someone to write new ones.)

Is there currently a way to read/write the raw bitstream for a full T1 
or E1 or a subset of channels?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

