Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270766AbTG0NKz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 09:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270767AbTG0NKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 09:10:55 -0400
Received: from nic.bme.hu ([152.66.115.1]:35799 "EHLO nic.bme.hu")
	by vger.kernel.org with ESMTP id S270766AbTG0NKy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 09:10:54 -0400
Message-ID: <3F23D27B.3070209@namesys.com>
Date: Sun, 27 Jul 2003 17:24:11 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
       torvalds@transmeta.com, marcelo@conectiva.com.br,
       mason <mason@namesys.com>
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
References: <3F1EF7DB.2010805@namesys.com> <20030726013301.6164e6e4.akpm@osdl.org>
In-Reply-To: <20030726013301.6164e6e4.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Hans Reiser <reiser@namesys.com> wrote:
>  
>
>>Please look at http://www.namesys.com/benchmarks/v4marks.html
>>    
>>
>
>It says "but since most users use ext3 with only meta-data journaling"
>which isn't really correct.  ext3's metadata-only journalling mode is
>writeback mode.
>
>Most people in fact use ext3's ordered mode, which provides the same data
>consistency guarantees on recovery as data journalling.
>
>Please compare against the ext3 in -mm.  It has tweaks which aren't yet
>merged, but which will be submitted soon.
>
>
>
>  
>
We are going to run a bunch more benchmarks when I get back, probably 
doing things like turning on htrees and tail combining and stuff, in 
lots of different combinations.  Ordered mode will be added, as well as 
making green have a uniform meaning for all the benchmarks;-).  This 
benchmark was just what could be done before I got on a plane.

-- 
Hans


