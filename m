Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261841AbULODZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbULODZd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 22:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbULODZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 22:25:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:60800 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261841AbULODZ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 22:25:26 -0500
Message-ID: <41BFAD9F.7080009@osdl.org>
Date: Tue, 14 Dec 2004 19:21:03 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Park Lee <parklee_sel@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to get the whole information dumped from kernel
References: <20041215031918.53569.qmail@web51505.mail.yahoo.com>
In-Reply-To: <20041215031918.53569.qmail@web51505.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Park Lee wrote:
> On Tue, 14 Dec 2004 at 08:04, Randy.Dunlap wrote:
> 
>>Park Lee wrote:
>>
>>>[snipped]
>>>[ ] Configure standard kernel features (for small
>>>systems)  ---> 
>>
>>Right here, press Y and the press Enter and more 
>>options (including KALLSYMS) will appear for you to 
>>make.
> 
> 
> Just now, I had a try. BUT there is no more options
> (including KALLSYMS) appear as what you said at all!
> What's the matter? ( I'm using Fedora Core 2, the
> Linux kernel version is 2.6.5).

Hi,
I can't say about FC2 in particular, but in looking
at 2.6.5 from kernel.org, it looks like this:

[*] Remove kernel features (for embedded systems)  --->

{enable above and press Enter, then see this:}

[*]   Load all symbols for debugging/kksymoops (NEW)

{enable above and save it}

Hope that helps, if not, please try (send) again.

-- 
~Randy
