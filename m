Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbULGUQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbULGUQH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 15:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbULGUPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 15:15:55 -0500
Received: from smtp30.hccnet.nl ([62.251.0.40]:32977 "EHLO smtp30.hccnet.nl")
	by vger.kernel.org with ESMTP id S261913AbULGUO0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 15:14:26 -0500
Message-ID: <41B60EE3.4070400@hccnet.nl>
Date: Tue, 07 Dec 2004 21:13:23 +0100
From: Ronald Moesbergen <r.moesbergen@hccnet.nl>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041121)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: paulkf@microgate.com, mail@kirya.ru
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ppp][2.6.10-rc3] Don't work pppd.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > On Mon, 2004-12-06 at 00:24 +0300, Kirill Yushkov wrote:
 >
 >> My VPN server on the base Poptop (pptpd) failed to work after the 
upgrade of
 >> the kernel from 2.6.10-rc2-bk1 to 2.6.10-rc3. In kernel 
2.6.10-rc2-bk1 and
 >> earlier versions the kernel pppd worked well.

 > I see no changes to the ppp drivers,
 > pty driver, or tty code between these versions.

 > It would help to recheck your setup and configuration and
 > then work through the rc2-bk series to identify more
 > precisely when this broke.

I've got the same problem but with pptp-client (pptpclient.sf.net). I 
did a binary search and found that with the same kernel and pptp config, 
kernel 2.6.10-rc2-bk13 works, and 2.6.10-rc2-bk14 doesn't. Hope that 
helps to narrow it down. Let me know if there is anything I can try.

Ronald.
