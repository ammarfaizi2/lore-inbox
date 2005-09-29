Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbVI2On1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbVI2On1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 10:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbVI2On1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 10:43:27 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:43220 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S932169AbVI2On0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 10:43:26 -0400
Date: Thu, 29 Sep 2005 16:43:20 +0200
From: Jan Kasprzak <kas@fi.muni.cz>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI/IRQ regressions in 2.6.13.2
Message-ID: <20050929144320.GO1901@fi.muni.cz>
References: <20050923171054.GB19763@fi.muni.cz> <20050928204510.GC19285@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050928204510.GC19285@kroah.com>
User-Agent: Mutt/1.4.1i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
: On Fri, Sep 23, 2005 at 07:10:54PM +0200, Jan Kasprzak wrote:
: > 	Hello,
: > 
: > I've tried to upgrade my Linux boxes to 2.6.13.2, and on some configurations
: > I have problems that IRQ stopped working or devices are not visible on
: > the PCI bus. These problems may be completely unrelated, though:
: 
: Can you see if 2.6.14-rc2 fixes the pci issues?
: 
	I have not been able to test the issue with part of PCI bus
missing from the lspci output on HP DL-585 quad opteron (the server is
in production use, I cannot reboot it just now), however the two other
problems (IRQ timeout on IDE controller and no IRQs on tg3 NIC) seem
to be fixed on 2.6.14-rc2.

	I will probably test the 2.6.14-rc2 on HP DL-585 tomorrow evening.
Thanks,

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/    Journal: http://www.fi.muni.cz/~kas/blog/ |
>>> $ cd my-kernel-tree-2.6                                              <<<
>>> $ dotest /path/to/mbox  # yes, Linus has no taste in naming scripts  <<<
