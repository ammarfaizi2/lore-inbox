Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751436AbWE2WTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbWE2WTi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 18:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbWE2WTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 18:19:38 -0400
Received: from ihug-mail.icp-qv1-irony5.iinet.net.au ([203.59.1.199]:46259
	"EHLO mail-ihug.icp-qv1-irony5.iinet.net.au") by vger.kernel.org
	with ESMTP id S1751436AbWE2WTh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 18:19:37 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.05,185,1146412800"; 
   d="scan'208"; a="777856407:sNHT76250646"
Message-ID: <447B7374.8040909@eyal.emu.id.au>
Date: Tue, 30 May 2006 08:19:32 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Debian Thunderbird 1.0.2 (X11/20060423)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc Perkel <marc@perkel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Asus K8N-VM Motherboard Ethernet Problem
References: <44793100.50707@perkel.com>
In-Reply-To: <44793100.50707@perkel.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Perkel wrote:
> Is there a problem with the forcedeth driver not being compatible with
> the Asus K8N-VM motherboard? I installed Fedora Core 5 and the Ethernet
> doesn't want to work. I installed the latest FC5 kernel which is some
> flavor og 2.6.16 and it still doesn't work. The FC4 CD and rescue disk
> don't work either. Windows XP however does work so I know that hardware
> is good.
> 
> lspci says the hardware is an nVidia MCP51 ethernet controller. What am
> I missing?

I had similar issues on A8N-VM. The device would stop working after some
packets initially got through and would not recover.

As I recall 'noapic' made it work reliably. nvidia has a linux binary
driver for the chipset which you can try (you probably already use the
binary video driver?).

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
	attach .zip as .dat
