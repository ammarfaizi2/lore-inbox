Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263567AbTD1Mzz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 08:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbTD1Mzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 08:55:55 -0400
Received: from mail.gmx.net ([213.165.65.60]:20112 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263567AbTD1Mzy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 08:55:54 -0400
Message-ID: <3EAD27B2.9010807@gmx.net>
Date: Mon, 28 Apr 2003 15:08:02 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Henti Smith <bain@tcsn.co.za>
CC: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: maximum possible memory limit ..
References: <20030424200524.5030a86b.bain@tcsn.co.za>
In-Reply-To: <20030424200524.5030a86b.bain@tcsn.co.za>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[CC:ing lse-tech because they know better than me]

Henti Smith wrote:
> Hi all 
> 
> I had a discussion with somebody watching the whole M$ server launch and mentioned then new systems supports up to a terabyte of ram. 
> I've tried looking for a hint at what the max memory support on linux is and cannot find it anywhere.
> 
> can somebody here enlighten me on just what the maximum amount of memory linux can deal with ? 

Linux supports up to 4 GB (~2^32 bytes) of memory on 32-bit
architectures and 64 GB (~2^36 bytes) on x86 with PAE. No other
operating system can support more on 32-bit since it is a limitation of
the hardware.
On 64-bit systems, Linux supports up to 16 EB (~2^64 bytes) of memory,
which is about 16 million times more than the 1 TB limit of MS.

Current Linux 2.4 allows 32 CPUs for 32-bit arches and 64 CPUs on 64-bit
arches. However, this limit is (was?) being removed in 2.5, so you can
have up to 32767 CPUs, which should be enough for you right now.
(Note: I said _right now_, lest anybody make jokes about 640K limit)


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/

