Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268032AbUIKIrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268032AbUIKIrK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 04:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268000AbUIKIrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 04:47:09 -0400
Received: from [62.159.120.65] ([62.159.120.65]:559 "EHLO
	srv-adh-vm-0007.adminsend.de") by vger.kernel.org with ESMTP
	id S267961AbUIKIqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 04:46:11 -0400
Message-ID: <4142BB2D.50907@adminsend.de>
Date: Sat, 11 Sep 2004 10:45:33 +0200
From: ADH <swing@adminsend.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 3ware 9500 ("3w-9xxx") w/ dual Opteron (Tyan 2885)
References: <2CdNY-57s-9@gated-at.bofh.it>
In-Reply-To: <2CdNY-57s-9@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ed,

can You provide more infos on the oops You encountered.

ciao
andi


Ed Hill wrote:

> Hi folks,
> 
> Has anyone managed to get a 3ware 9500-series RAID controller working
> stably on an SMP Opteron system?  Especially with a Tyan 2885 MB?  If
> so, would you be willing to share your kernel configuration info?
> 
> I'm trying to get a 3ware 9500 8-port card working on a Tyan 2885
> motherboard (dual Opterons) and have been experiencing numerous oopses:
> 
>   - 2.6.[78] w/ the included 3w-9xxx driver and ext3 FS:
>     Results in kernel oops after 1--2 hours of writing to the 
>     RAID array (happened four times).  The oops appears to be 
>     in ext3.
> 
>   - 2.6.8.1 w/ latest 3w-9xxx driver from 3ware and XFS FS:
>     Results in "Bad page state at prep_new_page" kernel errors
> 
> When not using the 3ware RAID array (that is, the array is mounted but
> no reads or writes are done to it), the machine is very stable--even
> under heavy CPU loads and lots of IO to local (non-RAID) IDE drives.
> 
> Any help/suggestions appreciated!
> 
> Ed
> 

