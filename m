Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263552AbTD1Mmp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 08:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263558AbTD1Mmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 08:42:44 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:2477 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S263552AbTD1Mml (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 08:42:41 -0400
Message-ID: <3EAD2467.8040101@namesys.com>
Date: Mon, 28 Apr 2003 16:53:59 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: rwhron@earthlink.net
CC: linux-kernel@vger.kernel.org
Subject: Re: [benchmarks] various filesystems on 2.5.68
References: <20030424124728.GA1477@rushmore>
In-Reply-To: <20030424124728.GA1477@rushmore>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rwhron@earthlink.net wrote:

>mount -t reiserfs -o defaults,noatime /dev/sdc1 /fs1
>
You should benchmark us with notail option if you want it to be fair 
compared to less space conserving filesystems.  This has a substantial 
performance impact, and since you don't measure space usage in these 
benchmarks....

>                          ---------------- Sequential ----------
>                          ----- Create -----    ---- Delete ----
>                   files   /sec  %CPU    Eff    /sec  %CPU   Eff
>2.5.68-ext3        65536  10828  70.3  15395   21160  98.0  2159
>2.5.68-reiserfs   131072   2935  37.3   7861    1787  25.7  6963
>
What is the meaning of the files parameter, and why is our number 
different from the other filesystems?


-- 
Hans


