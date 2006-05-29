Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbWE2Ryv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWE2Ryv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 13:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWE2Ryv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 13:54:51 -0400
Received: from pih-relay04.plus.net ([212.159.14.131]:33234 "EHLO
	pih-relay04.plus.net") by vger.kernel.org with ESMTP
	id S1751146AbWE2Ryu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 13:54:50 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Asus K8N-VM Motherboard Ethernet Problem
Date: Mon, 29 May 2006 18:54:47 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Marc Perkel <marc@perkel.com>
References: <44793100.50707@perkel.com> <20060528101849.GL13513@lug-owl.de> <447B3408.1020001@superbug.co.uk>
In-Reply-To: <447B3408.1020001@superbug.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605291854.48001.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 May 2006 18:48, James Courtier-Dutton wrote:
[snip irrelevant Other OS discussion]
>
> I can concur that the forcedeth is unreliable on nvidia based motherboards.
> I have a ethernet device that works with forcedeth.
> 0000:00:0a.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a3)
> 0000:00:0a.0 0680: 10de:0057 (rev a3)
>         Subsystem: 147b:1c12
>         Flags: 66MHz, fast devsel, IRQ 11
>         Memory at fe02f000 (32-bit, non-prefetchable) [size=4K]
>         I/O ports at fc00 [size=8]
>         Capabilities: [44] Power Management version 2
>
> It works in that it can actually send and receive packets.
> The problems are:
> 1) one cannot rmmod the forcedeth module. Even after ifdown etc.
> 2) the machine hangs randomly.
> Before someone asks, the MB has no serial port, so no stack trace
> available. 3) The netconsole fails to function with it.

File a bug report. What kernel version did you last test?

I have that exact ethernet controller (CK804) and cannot reproduce any of the 
problems you have listed on 2.6.17-rc5.

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
