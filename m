Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267603AbUHTHKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267603AbUHTHKt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 03:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267597AbUHTHKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 03:10:49 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:14518 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S267603AbUHTHG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 03:06:28 -0400
Message-ID: <4125A2F6.5050308@namesys.com>
Date: Fri, 20 Aug 2004 00:06:30 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Cherry <cherry@osdl.org>
CC: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Alexander Zarochentcev <zam@namesys.com>,
       Vladimir Demidov <demidov@namesys.com>
Subject: Re: 2.6.8.1-mm2
References: <20040819014204.2d412e9b.akpm@osdl.org> <1092927166.29916.0.camel@cherrybomb.pdx.osdl.net>
In-Reply-To: <1092927166.29916.0.camel@cherrybomb.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Cherry wrote:

>The new "errors" are from reiser4 code and they all appear to be...
>
>fs/reiser4/reiser4.h:18:2: #error "Please turn 4k stack off"
>
>  
>
zam, can you or Mr. Demidov work on using kmalloc to reduce stack usage?

Andrew suggested that for statically sized objects kmalloc is quite fast 
(one instruction I think he said), so my objection to kmallocing a lot 
has faded.
