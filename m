Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbTLCXFK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 18:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbTLCXFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 18:05:10 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:36107 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262190AbTLCXFD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 18:05:03 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: aacraid and large memory problem (2.6.0-test11)
Date: 3 Dec 2003 22:53:53 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bqlpi1$kbf$1@gatekeeper.tmr.com>
References: <1070488662.21904.6.camel@markh1.pdx.osdl.net> <20031203222840.6A4E6F7C86@voldemort.scrye.com>
X-Trace: gatekeeper.tmr.com 1070492033 20847 192.168.12.62 (3 Dec 2003 22:53:53 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031203222840.6A4E6F7C86@voldemort.scrye.com>,
Kevin Fenzi  <kevin@tummy.com> wrote:
| 
| >>>>> "Mark" == Mark Haverkamp <markh@osdl.org> writes:
| 
| Mark> I set up my machine to boot on the aacraid disk and it booted OK
| Mark> for me.  Maybe its a problem with a particular model?
| 
| Mark> lspci on mine says:
| 
| Mark> 02:04.0 RAID bus controller: Digital Equipment Corporation
| Mark> DECchip 21554 (rev 01) Subsystem: Adaptec Adaptec 5400S
| 
| This one says: 
| 
| 05:01.0 RAID bus controller: Adaptec AAC-RAID (rev 01)
|         Subsystem: Adaptec AAC-RAID
|         Flags: bus master, fast Back2Back, 66Mhz, slow devsel, latency 64, IRQ 96
|         Memory at f8000000 (32-bit, prefetchable) [size=64M]
|         Expansion ROM at <unassigned> [disabled] [size=64K]
|         Capabilities: [80] Power Management version 2
| 
| It's a 2200S controller. 
| bios version 6008
| 
| Mark> -- Mark Haverkamp <markh@osdl.org>
| 
| kevin

02:03.0 RAID bus controller: Digital Equipment Corporation DECchip 21554 (rev 01)
        Subsystem: Adaptec Dell PowerEdge RAID Controller 2
        Flags: bus master, medium devsel, latency 32, IRQ 18
        Memory at fe200000 (32-bit, non-prefetchable) [size=8K]
        I/O ports at f800 [size=256]
        Expansion ROM at fd000000 [disabled] [size=128K]
        Capabilities: <available only to root>

Sorry - it's back on 2.4, just thought this might be useful.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
