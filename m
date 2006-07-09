Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030430AbWGIHzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030430AbWGIHzk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 03:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030431AbWGIHzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 03:55:40 -0400
Received: from relay01.pair.com ([209.68.5.15]:47117 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S1030427AbWGIHzj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 03:55:39 -0400
X-pair-Authenticated: 71.197.50.189
From: Chase Venters <chase.venters@clientec.com>
Organization: Clientec, Inc.
To: "Abu M. Muttalib" <abum@aftek.com>
Subject: Re: Commenting out out_of_memory() function in __alloc_pages()
Date: Sun, 9 Jul 2006 02:55:10 -0500
User-Agent: KMail/1.9.3
Cc: "Robert Hancock" <hancockr@shaw.ca>, kernelnewbies@nl.linux.org,
       linux-newbie@vger.kernel.org, linux-kernel@vger.kernel.org,
       "linux-mm" <linux-mm@kvack.org>
References: <BKEKJNIHLJDCFGDBOHGMGEEJDCAA.abum@aftek.com>
In-Reply-To: <BKEKJNIHLJDCFGDBOHGMGEEJDCAA.abum@aftek.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607090255.34452.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 July 2006 01:10, Abu M. Muttalib wrote:
> I have a total of 16 MB RAM. My main concern is that I was running the same
> set of applications earlier on linux-2.4.19-rmk7-pxa1 and didn't get any
> out of memory. I am running the same application and get the OOM, though
> the appearance is not uniform, at times it comes on a freshly booted system
> and at times it didn't come when the system is on overnight.... Why I am
> getting here??? Is there any problem with linux-2.6.13?

I'm just guessing now, but it's possible that the default thresholds have 
changed from 2.4.19 to 2.6.13 (indeed, the amount of progress between those 
two versions is more than some OS kernels have seen in their lifetime).

You might look at Documentation/sysctl/vm.txt and check those settings on 
2.4.19 versus 2.6.13.

What application are you having trouble with?

> I have tried to check the application for memory leak with no success.
> There seems to be no memory leak.
>
> >Thanks,
> >Chase
>
> Regards,
> Abu.

Thanks,
Chase
