Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbUAaJTT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 04:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbUAaJTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 04:19:19 -0500
Received: from pop.gmx.net ([213.165.64.20]:19390 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262686AbUAaJTR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 04:19:17 -0500
X-Authenticated: #4512188
Message-ID: <401B7312.3060207@gmx.de>
Date: Sat, 31 Jan 2004 10:19:14 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nigel Cunningham <ncunningham@clear.net.nz>
CC: trelane@digitasaru.net, Luke-Jr <luke7jr@yahoo.com>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Swsusp-devel] Software Suspend 2.0
References: <1075436665.2086.3.camel@laptop-linux> <200401310622.17530.luke7jr@yahoo.com> <1075531042.18161.35.camel@laptop-linux> <20040131064757.GB7245@digitasaru.net> <1075532166.17727.41.camel@laptop-linux> <20040131071619.GD7245@digitasaru.net> <1075534088.18161.61.camel@laptop-linux> <20040131073848.GE7245@digitasaru.net> <1075537924.17730.88.camel@laptop-linux> <401B6F7A.5030103@gmx.de> <1075540107.17727.90.camel@laptop-linux>
In-Reply-To: <1075540107.17727.90.camel@laptop-linux>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:
> Hi.
> 
> On Sat, 2004-01-31 at 22:03, Prakash K. Cheemplavam wrote:
> 
>>>Get the latest 2.6.1 patch (revision 7) and latest core patch (2.0) from
>>>http://swsusp.sf.net.
>>
>>I am sorry, I only see a rev 6 patch. Will that also work?
> 
> 
> You're right. I got the revision number for 2.4.24 stuck in my head.
> rev6 is the right one.

Ok, just trying it out. So far:

Doing the kernel patch to 2.6.2-rc3, it asks me about a file missing in 
xfs. I skipped it. Then I used your patch you sent to lkml to fix things 
up. Finally I applied the core patch. Now it asks me

The next patch would create the file kernel/power/swsusp2.c,
which already exists!  Assume -R? [n]

Should this happen? What to do now?

Prakash
