Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264291AbUAaJuH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 04:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264300AbUAaJuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 04:50:07 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:32936 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S264291AbUAaJuD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 04:50:03 -0500
Date: Sat, 31 Jan 2004 22:51:25 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [Swsusp-devel] Software Suspend 2.0
In-reply-to: <401B7312.3060207@gmx.de>
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Cc: trelane@digitasaru.net, Luke-Jr <luke7jr@yahoo.com>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1075542685.25454.124.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1075436665.2086.3.camel@laptop-linux>
 <200401310622.17530.luke7jr@yahoo.com>
 <1075531042.18161.35.camel@laptop-linux>
 <20040131064757.GB7245@digitasaru.net>
 <1075532166.17727.41.camel@laptop-linux>
 <20040131071619.GD7245@digitasaru.net>
 <1075534088.18161.61.camel@laptop-linux>
 <20040131073848.GE7245@digitasaru.net>
 <1075537924.17730.88.camel@laptop-linux> <401B6F7A.5030103@gmx.de>
 <1075540107.17727.90.camel@laptop-linux> <401B7312.3060207@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

My error. My patch script has put kernel/power/swsusp2.c in the version
specific patch and I didn't notice. Just ignore the reject when you
apply the core patch and you should be okay (there is a small change
that belongs in the next core patch).

Humble apologies,

Nigel

On Sat, 2004-01-31 at 22:19, Prakash K. Cheemplavam wrote:
> Ok, just trying it out. So far:
> 
> Doing the kernel patch to 2.6.2-rc3, it asks me about a file missing in 
> xfs. I skipped it. Then I used your patch you sent to lkml to fix things 
> up. Finally I applied the core patch. Now it asks me
> 
> The next patch would create the file kernel/power/swsusp2.c,
> which already exists!  Assume -R? [n]
> 
> Should this happen? What to do now?
> 
> Prakash
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

