Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264026AbUESMmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264026AbUESMmo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 08:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264129AbUESMmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 08:42:44 -0400
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:7600 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264026AbUESMmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 08:42:42 -0400
Message-ID: <40AB5639.7060806@yahoo.com.au>
Date: Wed, 19 May 2004 22:42:33 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: elenstev@mesatop.com
CC: Wayne Scott <wscott@bitmover.com>, mason@suse.com, torvalds@osdl.org,
       akpm@osdl.org, lm@bitmover.com, wli@holomorphy.com, hugh@veritas.com,
       adi@bitmover.com, support@bitmover.com, linux-kernel@vger.kernel.org,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: 1352 NUL bytes at the end of a page?
References: <Pine.LNX.4.58.0405180728510.25502@ppc970.osdl.org>	<200405190453.31844.elenstev@mesatop.com>	<1084968622.27142.5.camel@watt.suse.com> <20040519.072009.92566322.wscott@bitmover.com>
In-Reply-To: <20040519.072009.92566322.wscott@bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wayne Scott wrote:
> From: Chris Mason <mason@suse.com>
> 
>>Good to hear.  We probably still need Andrew's truncate fix, this just
>>isn't the right workload to show it.  Andrew, that reiserfs fix survived
>>testing here, could you please include it?
>>
>>-chris
> 
> 
> BTW. We have had one other person report a similar failure.
> 
> http://db.bitkeeper.com/cgi-bin/bugdb.cgi?.page=view&id=2004-05-19-001
> 
> But if sounds like this problem is now understood.  It was a pleasure
> to watch you guys, and someone should buy Steven a beer.  Or perhaps
> order a pizza for his family because I suspect this took some of their
> time.
> 

Yep. Thanks for your help Steven.

I don't think anyone has cleared up the performance regression
problem yet though, so I'll have to bug you a bit more.

Steven, with all else being equal, you said you found a 2.6.3 SuSE
kernel to significantly outperform 2.6.6, is that right? If so can
you try the same test with plain 2.6.3 please? We'll go from there.

This one isn't urgent, because I suspect it could be something
specific to the SuSE kernel rather than a regression in Linus' tree
- we've heard no other complaints... so just whenever you get the
chance.

Nick
