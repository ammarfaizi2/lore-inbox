Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267620AbUHWWre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267620AbUHWWre (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 18:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268014AbUHWWqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 18:46:49 -0400
Received: from mta03-svc.ntlworld.com ([62.253.162.43]:37850 "EHLO
	mta03-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S267634AbUHWWd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 18:33:26 -0400
Message-ID: <412A70B1.6010404@poggs.co.uk>
Date: Mon, 23 Aug 2004 23:33:21 +0100
From: Peter Hicks <peter.hicks@poggs.co.uk>
Organization: Poggs Computer Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.7.2) Gecko/20040819 Debian/1.5-3 StumbleUpon/1.89
X-Accept-Language: en-gb, en-us, en-au, en-ie, en
MIME-Version: 1.0
To: Jens Maurer <Jens.Maurer@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1 crash on Toshiba Tecra 9100
References: <20040822161338.GA21087@tufnell.lon1.poggs.net> <412A2872.5030004@gmx.net>
In-Reply-To: <412A2872.5030004@gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Maurer wrote:

>>  [<c0208dbd>] pcibios_enable_device+0x14/0x17
>>  [<c019ca84>] pci_enable_device_bars+0x1e/0x32
>>  [<e0937b7c>] agp_intel_probe+0x10e/0x409 [intel_agp]
> 
> Hm... The oops happens while inserting the intel_agp module.
> CONFIG_EDD is for boot disk detection.  I fail to see any
> relationship whatsoever between these two.

I'll get back to you on that - I didn't notice the blindingly obvious. 
However I'm fairly certain CONFIG_EDD causes the AGP oops.

I'll do some more playing around and get back.


Peter.

-- 
Peter Hicks | e: my.name@poggs.co.uk | g: 0xE7C839F4 | w: www.poggs.com
