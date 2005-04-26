Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbVDZSPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVDZSPw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 14:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVDZSPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 14:15:49 -0400
Received: from terminus.zytor.com ([209.128.68.124]:26498 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261539AbVDZSPi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 14:15:38 -0400
Message-ID: <426E852A.40904@zytor.com>
Date: Tue, 26 Apr 2005 11:15:06 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Mike Taht <mike.taht@timesys.com>, Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: Mercurial 0.3 vs git benchmarks
References: <20050426004111.GI21897@waste.org> <Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org> <426DA7B5.2080204@timesys.com> <Pine.LNX.4.58.0504251938210.18901@ppc970.osdl.org> <Pine.LNX.4.58.0504252032500.18901@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504252032500.18901@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> And don't try to make me explain why the patchbomb has any IO time at all,
> it should all have fit in the cache, but I think the writeback logic
> kicked in.

The default log size on ext3 is quite small.  Making the log larger 
probably would have helped.

	-hpa
