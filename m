Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbWBPWJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWBPWJs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 17:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932567AbWBPWJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 17:09:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:52715 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932355AbWBPWJs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 17:09:48 -0500
X-Authenticated: #31060655
Message-ID: <43F4F811.1090308@gmx.net>
Date: Thu, 16 Feb 2006 23:09:21 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.12) Gecko/20050921
X-Accept-Language: de, en
MIME-Version: 1.0
To: s.schmidt@avm.de
CC: opensuse-factory@opensuse.org, Greg KH <greg@kroah.com>, torvalds@osdl.org,
       kkeil@suse.de, linux-kernel@vger.kernel.org,
       libusb-devel@lists.sourceforge.net
Subject: Re: [opensuse-factory] Re[2]: 2.6.16 serious consequences / GPL_EXPORT_SYMBOL
 / USB drivers of major vendor excluded
References: <OFED05BE20.31E2BACE-ONC1257115.005DE6CA-C1257117.004F2C48@avm.de>
In-Reply-To: <OFED05BE20.31E2BACE-ONC1257115.005DE6CA-C1257117.004F2C48@avm.de>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

s.schmidt@avm.de wrote:
> 
> The user space does not ensure the reliability of time critical analog
> services like Fax G3 or analog modem emulations. This quality of service
> can only be guaranteed within the kernel space.
> [...] To anticipate any "open vs. closed source" discussion: Only a
> handful of companies worldwide have such know-how. With regard to our
> competitive situation, we have to protect our hard-won intellectual
> property and therefore cannot open the closed source part of the driver.

Thanks for clarifying the situation.

Since your intellectual property is in the DSP algorithms, are there
any obstacles opensourcing the parts of the ISDN drivers which only
handle normal ISDN without fax/modem emulation? This would make every
distribution out there support your devices without any additional work
on your side.
You can still offer your full-featured drivers as usual.

Regards,
Carl-Daniel Hailfinger
