Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267624AbUI1H7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267624AbUI1H7h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 03:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267633AbUI1H7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 03:59:37 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:38811 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267624AbUI1H7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 03:59:34 -0400
Message-ID: <415915F0.2000803@yahoo.com.au>
Date: Tue, 28 Sep 2004 17:42:40 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Ed Schouten <edschouten@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Patch] i386: Xbox support
References: <65184.217.121.83.210.1096308147.squirrel@217.121.83.210>	 <4158AA5B.8090601@yahoo.com.au> <dc54396f040927214651393131@mail.gmail.com>
In-Reply-To: <dc54396f040927214651393131@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Schouten wrote:
> Hello Nick,
> 
> On Tue, 28 Sep 2004 10:03:39 +1000, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>Any real point to merging this? (I honestly don't know, I don't follow the
>>xbox hacking scene).
> 
> 
> Yes, it does (in my opinion). This small 7 KB patch allows you to run
> a vanilla kernel on the machine (with exception of the video driver).
> 
> I also noticed my previous mailclient (Squirrelmail) did some
> linebreaking. Please notice:
> 
> + if ((bus == 0) && !PCI_SLOT(devfn) && ((PCI_FUNC(devfn) == 1) ||
> (PCI_FUNC(devfn) == 2)))
> 
> should be one line ;-)
> 
> Yours sincerely,

Well, I ask because there is probably quite a large number of embedded type
devices devices that you could "just add a small patch for" to get it working.

The added fact that you have to "hack" the hardware (I think?) to even get
it to run Linux makes it probably a bit more questionable (it is great that
we can run on xbox, but maybe not too harmful to keep it as an external patch).

Anyway I've otherwise got no objections ;) if you can convince Andrew and/or
Linus to merge it, then fine.
