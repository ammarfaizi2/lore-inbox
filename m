Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbUB0I6O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 03:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbUB0I6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 03:58:14 -0500
Received: from pop.gmx.de ([213.165.64.20]:10122 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261738AbUB0I6N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 03:58:13 -0500
X-Authenticated: #4512188
Message-ID: <403F06A1.6040209@gmx.de>
Date: Fri, 27 Feb 2004 09:58:09 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm4, sensors broken
References: <20040225185536.57b56716.akpm@osdl.org>	<403E82D8.3030209@gmx.de> <20040226160355.35ced535.akpm@osdl.org>
In-Reply-To: <20040226160355.35ced535.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> "Prakash K. Cheemplavam" <PrakashKC@gmx.de> wrote:
> 
>>this release made my sensors broken. With mm3 it worked nicely.
> 
> 
> Useful info.   If you have time, could you please do a `patch -p1 -R'
> of ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3/2.6.3-mm4/broken-out/bk-i2c.patch
> and see if that fixes it up?

Yes, this fixes it. My temperatures are available again and "sensors" 
reports everything, as well.

Prakash
