Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbUJYLd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbUJYLd6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 07:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbUJYLd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 07:33:58 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:1871 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261566AbUJYLd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 07:33:56 -0400
Message-ID: <417CE49B.4060308@yahoo.com.au>
Date: Mon, 25 Oct 2004 21:33:47 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Justin Piszcz <jpiszcz@lucidpixels.com>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Kernel 2.6.9 Page Allocation Failures w/TSO+rollup.patch
References: <Pine.LNX.4.61.0410250645540.9868@p500>
In-Reply-To: <Pine.LNX.4.61.0410250645540.9868@p500>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Piszcz wrote:
> I guess people who get this should just stick with 2.6.8.1?
> 

Does it cause any noticable problems? If not, then stay with
2.6.9.

However, it would be nice to get to the bottom of it. It might
just be happening by chance on 2.6.9 but not 2.6.8.1 though...

Anyway, how often are you getting the messages? How many
ethernet cards in the system?

Can you run a kernel with sysrq support, and do `SysRq+M`
(close to when the allocation failure happens if possible, but
otherwise on a normally running system after it has been up
for a while). Then send in the dmesg.

Thanks,
Nick
