Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964872AbWEBPSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbWEBPSA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 11:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbWEBPSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 11:18:00 -0400
Received: from dvhart.com ([64.146.134.43]:46811 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S964872AbWEBPR7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 11:17:59 -0400
Message-ID: <44577822.8050103@mbligh.org>
Date: Tue, 02 May 2006 08:17:54 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: assert/crash in __rmqueue() when enabling CONFIG_NUMA
References: <20060419112130.GA22648@elte.hu> <200605020905.29400.ak@suse.de> <44576688.6050607@mbligh.org> <200605021703.37195.ak@suse.de>
In-Reply-To: <200605021703.37195.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Tuesday 02 May 2006 16:02, Martin J. Bligh wrote:
> 
>>>Oh that's a 32bit kernel. I don't think the 32bit NUMA has ever worked
>>>anywhere but some Summit systems (at least every time I tried it it blew up 
>>>on me and nobody seems to use it regularly). Maybe it would be finally time to mark it 
>>>CONFIG_BROKEN though or just remove it (even by design it doesn't work very well) 
>>
>>Bollocks. It works fine, 
> 
> On what kind of box? Some summit system, right?

Summit and NUMA-Q, ie everything we originally created it for.

> Well, it doesn't work for Ingo clearly. My own experiences every time
> I tried it were similar.

What platform?

> I think I stand by my original statement.

If it works fine on some platforms and not on others, I would venture to
suggest it's a platform-specific issue, and marking the whole thing as
CONFIG_BROKEN would be an entirely inappropriate overreaction to what
is probably a simple bug.

M.
