Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263631AbTDDNgH (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 08:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263630AbTDDNdv (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 08:33:51 -0500
Received: from tag.witbe.net ([81.88.96.48]:35601 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S263552AbTDDN3l (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 08:29:41 -0500
From: "Paul Rolland" <rol@as2917.net>
To: "'Michael Knigge'" <Michael.Knigge@set-software.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Strange e1000
Date: Fri, 4 Apr 2003 15:41:09 +0200
Message-ID: <043501c2faaf$da061e10$3f00a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <20030404.7255311@knigge.local.net>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> when I load the e1000 module, my NIC is recognized. Then, "pump -i 
> eth0" is called (DHCP-Client), the message "e1000: eth0 NIC 
> Link is Up 
> 1000 Mbps Full Duplex" appears and after some time I get the message 
> "operation failed".
> 
> When I sleep some time (currently 20 seconds) before doing 
> the "pump", 
> everything works as expected.
> 
> What the hell is happening here? Ok, I got it working with the 
> 20-sec-sleep but this is not the way it sould work...
> 
> My Board is a Gigabyte GA-7ZXR (1.0) and the Intel NIC is a PRO/1000 
> MT (should be the 82540OEM Chip). The NIC is attached to a NetGear 
> FSM726S Switch (24x100 + 2x1000). It is currenty the only box 
> attached 

Could it be possible that the 1000MBps FD on the e1000 side is
a local configuration, and that it needs some time to discuss with
the Netgear switch to negotiate correctly speed and duplex before 
working correctly ? (i.e. 20 sec = negotiation time)

Regards,
Paul

