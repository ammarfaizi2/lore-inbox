Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266213AbUHWRZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266213AbUHWRZn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 13:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266259AbUHWRZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 13:25:31 -0400
Received: from imap.gmx.net ([213.165.64.20]:32711 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266213AbUHWRYw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 13:24:52 -0400
X-Authenticated: #5874409
Message-ID: <412A2872.5030004@gmx.net>
Date: Mon, 23 Aug 2004 19:25:06 +0200
From: Jens Maurer <Jens.Maurer@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Hicks <peter.hicks@poggs.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1 crash on Toshiba Tecra 9100
References: <20040822161338.GA21087@tufnell.lon1.poggs.net>
In-Reply-To: <20040822161338.GA21087@tufnell.lon1.poggs.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Peter Hicks wrote:
> ... that CONFIG_EDD causes the following oops whilst booting.

>  [<c0208dbd>] pcibios_enable_device+0x14/0x17
>  [<c019ca84>] pci_enable_device_bars+0x1e/0x32
>  [<e0937b7c>] agp_intel_probe+0x10e/0x409 [intel_agp]

Hm... The oops happens while inserting the intel_agp module.
CONFIG_EDD is for boot disk detection.  I fail to see any
relationship whatsoever between these two.

Jens Maurer


