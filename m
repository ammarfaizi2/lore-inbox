Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268445AbUJHKMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268445AbUJHKMa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 06:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268496AbUJHKMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 06:12:30 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:29873 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268445AbUJHKM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 06:12:29 -0400
Message-ID: <41666794.3040701@yahoo.com.au>
Date: Fri, 08 Oct 2004 20:10:28 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
Subject: Re: kswapd in tight loop 2.6.9-rc3-bk-recent
References: <20041007164044.23bac609.akpm@osdl.org> <4165E0A7.7080305@yahoo.com.au> <20041007174242.3dd6facd.akpm@osdl.org> <20041007184134.S2357@build.pdx.osdl.net> <20041007185131.T2357@build.pdx.osdl.net> <20041007185352.60e07b2f.akpm@osdl.org> <4165FF7B.1070302@cyberone.com.au> <20041007200109.57ce24ae.akpm@osdl.org> <416605CC.2080204@cyberone.com.au> <20041007203048.298029ab.akpm@osdl.org> <20041007222119.X2357@build.pdx.osdl.net>
In-Reply-To: <20041007222119.X2357@build.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Andrew Morton (akpm@osdl.org) wrote:
> 
>>Chris, do you have time to test this, against -linus?
> 
> 
> Yeah.  This patch held up against the simple testing, as did Nick's (not
> the most recent combined one from him).
> 

Thanks. Any/all patches should do much the same job.

I'm pretty confident this was just a minor artifact brought out
by an earlier change, and things still look good for 2.6.9.
