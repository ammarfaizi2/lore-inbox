Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264622AbUEUXxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264622AbUEUXxd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264488AbUEUXww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 19:52:52 -0400
Received: from imap.gmx.net ([213.165.64.20]:9878 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264857AbUEUXiD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:38:03 -0400
X-Authenticated: #4512188
Message-ID: <40ACE1AC.3000803@gmx.de>
Date: Thu, 20 May 2004 18:49:48 +0200
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040504)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: john weber <weber@sixbit.org>, linux-kernel@vger.kernel.org
Subject: Re: Performance Tuning
References: <20040520120514.GA29540@sixbit.org> <200405201642.i4KGgDgJ000683@turing-police.cc.vt.edu>
In-Reply-To: <200405201642.i4KGgDgJ000683@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Thu, 20 May 2004 12:05:15 -0000, john weber <weber@sixbit.org>  said:
> 
> 
>>Kernel compiles take 6m38s on my P4 2.8GHz (with HT enabled) and 
>>512 MB RAM as compared to 20-30 seconds reported by folks online. 
>>I am running kernel 2.6.6.
[snip]
> Seriously - the only way to do a kernel build in 20 seconds is to use 'make
> -j20' or so, and have enough processors to handle it, and enough RAM so that
> you can basically do the whole thing in the fin-core cache rather than beating
> on the disk....

20sec sounds very far from reality for me. I have athlon xp@2.2GHz and 
with gcc3.4 it takes about 4min to compile a 2.6.6-mm kernel. Using 
gcc3.3.x it needs minutes more.

Prakash
