Return-Path: <linux-kernel-owner+w=401wt.eu-S932512AbXABBVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbXABBVk (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 20:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932636AbXABBVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 20:21:40 -0500
Received: from terminus.zytor.com ([192.83.249.54]:37565 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932512AbXABBVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 20:21:40 -0500
Message-ID: <4599B38E.6020706@zytor.com>
Date: Mon, 01 Jan 2007 17:21:18 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Bob Copeland <me@bobcopeland.com>, Dave Jones <davej@redhat.com>,
       "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: my handy-dandy, "coding style" script
References: <Pine.LNX.4.64.0612191044170.7588@localhost.localdomain>  <20061219164146.GI25461@redhat.com> <b6c5339f0612190942l5a3ea48ft3315ab991ffd4f32@mail.gmail.com> <Pine.LNX.4.61.0612192125460.20733@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0612192125460.20733@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>>>  just for fun, i threw the following together to peruse the tree (or
>>>> any subdirectory) and look for stuff that violates the CodingStyle
>>>> guide.  clearly, it's far from complete and very ad hoc, but it's
>>>> amusing.  extra searches happily accepted.
>>> I had a bunch of similar greps that I've recently been half-assedly
>>> putting together into a single script too.
>>> See http://www.codemonkey.org.uk/projects/findbugs/
>> I don't know if anyone cares about them anymore, since I think gcc
>> grew some smarts in the area recently, but there are a lot of lines of
>> code matching "static int.*= *0;" and equivalents in the driver tree.
> 
> I'd really like to see the C compiler being enhanced to detect
> "stupid casts", i.e. those, which when removed, do not change (a) the outcome
> (b) the compiler warnings/error output.
> 

If you made it issue warnings for that, then it's going to be ever more 
painful to write generic macros.

	-hpa
