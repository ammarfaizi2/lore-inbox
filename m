Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261967AbULGXKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbULGXKs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 18:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbULGXKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 18:10:48 -0500
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:17472 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S261967AbULGXKm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 18:10:42 -0500
Message-ID: <41B63861.8060601@microgate.com>
Date: Tue, 07 Dec 2004 17:10:25 -0600
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Phil Oester <kernel@linuxace.com>
CC: Ronald Moesbergen <r.moesbergen@hccnet.nl>, mail@kirya.ru,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ppp][2.6.10-rc3] Don't work pppd.
References: <41B60EE3.4070400@hccnet.nl> <20041207204223.GA26238@linuxace.com>
In-Reply-To: <20041207204223.GA26238@linuxace.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Oester wrote:
> On Tue, Dec 07, 2004 at 09:13:23PM +0100, Ronald Moesbergen wrote:
> 
>>I've got the same problem but with pptp-client (pptpclient.sf.net). I 
>>did a binary search and found that with the same kernel and pptp config, 
>>kernel 2.6.10-rc2-bk13 works, and 2.6.10-rc2-bk14 doesn't. Hope that 
>>helps to narrow it down. Let me know if there is anything I can try.
> 
> 
> Read the archives...a patch was submitted to fix this today -- look for
> select().

To be fair it was submitted under a different thread. :-)

Summary: It was a net code change affecting pptp and
not directly related to the PPP/pty/tty code.

--
Paul Fulghum
paulkf@microgate.com


