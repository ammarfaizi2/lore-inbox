Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264210AbUEMOCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264210AbUEMOCk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 10:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264212AbUEMOCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 10:02:40 -0400
Received: from zork.zork.net ([64.81.246.102]:1690 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S264210AbUEMOCd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 10:02:33 -0400
To: Andi Kleen <ak@suse.de>
Cc: Dave Jones <davej@redhat.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: i810 AGP fails to initialise (was Re: 2.6.6-mm2)
References: <20040513032736.40651f8e.akpm@osdl.org>
	<6usme4v66s.fsf@zork.zork.net> <20040513135308.GA2622@redhat.com>
	<20040513155841.6022e7b0.ak@suse.de>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: Andi Kleen <ak@suse.de>, Dave Jones <davej@redhat.com>, 
 akpm@osdl.org, linux-kernel@vger.kernel.org
Date: Thu, 13 May 2004 15:02:25 +0100
In-Reply-To: <20040513155841.6022e7b0.ak@suse.de> (Andi Kleen's message of
 "Thu, 13 May 2004 15:58:41 +0200")
Message-ID: <6ulljwtoge.fsf@zork.zork.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> On Thu, 13 May 2004 14:53:08 +0100
> Dave Jones <davej@redhat.com> wrote:
>
>> 
>> Damn, probably something trivially wrong in Andi's changes.
>> 
>> Andi?
>
> lspci and lspci -n of the failing system please.

0000:00:00.0 Host bridge: Intel Corp. 82810E DC-133 GMCH [Graphics Memory Controller Hub] (rev 03)
0000:00:01.0 VGA compatible controller: Intel Corp. 82810E DC-133 CGC [Chipset Graphics Controller] (rev 03)
0000:00:1e.0 PCI bridge: Intel Corp. 82801AA PCI Bridge (rev 02)
0000:00:1f.0 ISA bridge: Intel Corp. 82801AA ISA Bridge (LPC) (rev 02)
0000:00:1f.1 IDE interface: Intel Corp. 82801AA IDE (rev 02)
0000:00:1f.2 USB Controller: Intel Corp. 82801AA USB (rev 02)
0000:00:1f.3 SMBus: Intel Corp. 82801AA SMBus (rev 02)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801AA AC'97 Audio (rev 02)
0000:01:0c.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 78)

0000:00:00.0 Class 0600: 8086:7124 (rev 03)
0000:00:01.0 Class 0300: 8086:7125 (rev 03)
0000:00:1e.0 Class 0604: 8086:2418 (rev 02)
0000:00:1f.0 Class 0601: 8086:2410 (rev 02)
0000:00:1f.1 Class 0101: 8086:2411 (rev 02)
0000:00:1f.2 Class 0c03: 8086:2412 (rev 02)
0000:00:1f.3 Class 0c05: 8086:2413 (rev 02)
0000:00:1f.5 Class 0401: 8086:2415 (rev 02)
0000:01:0c.0 Class 0200: 10b7:9200 (rev 78)

