Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030425AbWAXJoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030425AbWAXJoF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 04:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030429AbWAXJoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 04:44:05 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:38288 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1030425AbWAXJoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 04:44:03 -0500
Message-ID: <43D5F6DD.70702@t-online.de>
Date: Tue, 24 Jan 2006 10:43:57 +0100
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.10) Gecko/20050726
X-Accept-Language: de, en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] sky2 broken for Yukon PCI-E Gigabit Ethernet Controller
 11ab:4362 (rev 19)
References: <43D1C99E.2000506@t-online.de>	<20060123101538.14d21bf4@dxpl.pdx.osdl.net>	<43D52C69.5090707@t-online.de> <20060123112751.2e3f1b15@dxpl.pdx.osdl.net>
In-Reply-To: <20060123112751.2e3f1b15@dxpl.pdx.osdl.net>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: XRH06EZfoezuaBnTeXDSc3A36MK+GVFjqxyO8NFyvvOePhA7tJg24d@t-dialin.net
X-TOI-MSGID: b33ac746-ea41-4e96-a9bf-26a16aa9f745
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger schrieb:

>Could you try turning off rx checksumming (with ethtool).
>	ethtool -K eth0 rx off
>
>There probably still are (generic) bugs in the netfilter code for CHECKSUM_HW
>socket buffers.
>
>  
>
"ethtool -K eth0 rx off" does cure my problem with sky2.

Anybody is invited to send patches as the problem is 100% reproducible here.

cu,
 Knut

