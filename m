Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbTD1VV3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 17:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbTD1VV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 17:21:29 -0400
Received: from mallard.mail.pas.earthlink.net ([207.217.120.48]:41724 "EHLO
	mallard.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S261280AbTD1VV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 17:21:28 -0400
Date: Mon, 28 Apr 2003 17:41:04 -0400
To: reiser@namesys.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [benchmarks] various filesystems on 2.5.68
Message-ID: <20030428214104.GA20162@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You should benchmark us with notail option if you want it to be fair
> compared to less space conserving filesystems.  

Thanks, I'll start using notail on reiserfs.

>>                         ----- Create -----    ---- Delete ----
>>                  files   /sec  %CPU    Eff    /sec  %CPU   Eff
>>2.5.68-ext3        65536  10828  70.3  15395   21160  98.0  2159
>>2.5.68-reiserfs   131072   2935  37.3   7861    1787  25.7  6963

> What is the meaning of the files parameter, and why is our number
> different from the other filesystems?

I'll fix that too.  reiserfs has been more efficient than ext2 with
a lot of files.  Using less than 131072 files wasn't giving results for 
some tests on reiserfs.  

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

