Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264875AbUAOPy4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 10:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264902AbUAOPyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 10:54:55 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:19358
	"EHLO gaimboi.tmr.com") by vger.kernel.org with ESMTP
	id S264875AbUAOPyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 10:54:53 -0500
Message-ID: <4006B78E.2000607@tmr.com>
Date: Thu, 15 Jan 2004 10:53:50 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
CC: Valdis.Kletnieks@vt.edu, Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: What SCSI in the IBM?
References: <20040109150512.GF24295@rdlg.net> <200401091515.i09FFSDM030918@turing-police.cc.vt.edu> <20040109152016.GH24295@rdlg.net>
In-Reply-To: <20040109152016.GH24295@rdlg.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert L. Harris wrote:
> Thus spake Valdis.Kletnieks@vt.edu (Valdis.Kletnieks@vt.edu):
> 
> 
>>On Fri, 09 Jan 2004 10:05:12 EST, "Robert L. Harris" <Robert.L.Harris@rdlg.net>  said:
>>
>>
>>>The network cards in this IBM came up great once I found the right port.
>>>Now though I'm trying to find what SCSI driver to use. 
>>
>>What IBM?  Laptop? PC? Netfinity? RS6K? e/i/p/z-series?
> 
> 
> Ok, I found the "isa-pnp" module which fixed the unresolved module but
> now the sym driver also just give no device errors.  This is a 2U Xeon
> "eServer" model number x345.

Unfortunately all mine have ServRAID cards to do the SCSI ops, so I have 
no idea. However:



$ lspci
00:00.0 Host bridge: ServerWorks: Unknown device 0012 (rev 13)
00:00.1 Host bridge: ServerWorks: Unknown device 0012
00:00.2 Host bridge: ServerWorks: Unknown device 0000
00:05.0 Bridge: IBM: Unknown device 010f
00:06.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
00:0f.0 Host bridge: ServerWorks CSB5 South Bridge (rev 93)
00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93)
00:0f.2 USB Controller: ServerWorks OSB4/CSB5 USB Controller (rev 05)
00:0f.3 ISA bridge: ServerWorks: Unknown device 0225
00:10.0 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
00:10.2 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
00:11.0 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
00:11.2 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
02:03.0 RAID bus controller: IBM Netfinity ServeRAID controller
06:08.0 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet 
Controller (rev 01)
06:08.1 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet 
Controller (rev 01)
08:02.0 RAID bus controller: IBM Netfinity ServeRAID controller

is what I show. I guess that doesn't help.
-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
