Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbTIOPQZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 11:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbTIOPQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 11:16:25 -0400
Received: from citrine.spiritone.com ([216.99.193.133]:48326 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S261448AbTIOPQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 11:16:24 -0400
Date: Mon, 15 Sep 2003 08:15:25 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Wade <neroz@ii.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] add a config option for -Os compilation
Message-ID: <1526740000.1063638924@[10.10.2.4]>
In-Reply-To: <1063551468.14837.5.camel@dhcp23.swansea.linux.org.uk>
References: <20030914121655.GS27368@fs.tum.de>  <3F6472F4.8080509@ii.net> <1063551468.14837.5.camel@dhcp23.swansea.linux.org.uk>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Alan Cox <alan@lxorguk.ukuu.org.uk> wrote (on Sunday, September 14, 2003 15:57:49 +0100):

> On Sul, 2003-09-14 at 14:53, Wade wrote:
>> Adrian Bunk wrote:
>> > The patch below adds a config option OPTIMIZE_FOR_SIZE for telling gcc 
>> > to use -Os instead of -O2. Besides this, it removes constructs on 
>> > architectures that had a -Os hardcoded in their Makefiles.
>> 
>> Someone told me that -Os is actually faster than -O2 for Athlons, is 
>> that true?
> 
> On gcc 2.95 -Os was faster for most stuff. I would intuitively expect
> the best result to be a mix varied by function but I don't think gcc has
> the support to do that.
> 
> I've also not benched gcc 3.2 -Os v -O2 at real workloads - thats a 
> nice little project for someone.

I think it depends heavily on the chip - I tried 2.95 and 3.3. For me,
-Os was slower for both, but I have a 2MB L2 cache. If you have a 128K
celeron or something, I'm sure it'd be faster.

M.

