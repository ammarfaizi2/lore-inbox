Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262251AbVHCPlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbVHCPlQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 11:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262268AbVHCPlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 11:41:16 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:17077 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S262251AbVHCPlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 11:41:15 -0400
From: Grant Coady <lkml@dodo.com.au>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc5 randconfig kernel build errors
Date: Thu, 04 Aug 2005 01:41:11 +1000
Organization: www.scatter.mine.nu
Reply-To: lkml@dodo.com.au
Message-ID: <gmm1f1lnevmoo47vsgpeub6gajgqu8c4qq@4ax.com>
References: <lrque1drc20ev6o6441mn918e753r7vmki@4ax.com> <1651f199ie23tv14qv8jnnc53m97qdk1uh@4ax.com> <20050803112050.GL4029@stusta.de>
In-Reply-To: <20050803112050.GL4029@stusta.de>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,
On Wed, 3 Aug 2005 13:20:50 +0200, Adrian Bunk <bunk@stusta.de> wrote:

>> 
>> After 300 random builds, add one more error:
>> drivers/acpi/osl.c:261: error: `AmlCode' undeclared (first use in this function)
>> drivers/acpi/osl.c:61:10: empty file name in #include
>
>Please exclude builds with CONFIG_STANDALONE=n.
Okay.
>
>And please don't send every new error you are finding to this list.
Go tell the dimwits not trimming their posts to control themselves, 
I'm generating minimal traffic with this project.  Certainly far 
less traffic then that imbecile arguing for _his_ default setting.

>As I've already said generating the errors is the the easy part -
>analyzing them is the real work.

Starting somewhere, I'll settle :)  It is this feedback I need at 
start -- sorts of things to exclude.  I'll not get any feedback 
without reporting stuff to the list.
>
>It would be best if you would do this yourself and send specific bug 
>reports (or even patches) for the problems you've find.

I looked at that AmlCode error source file and grepping for a match 
failed for entire source tree, so did not understand it.  
>
>If you want to publish the errors you've found, send a pointer to a 
>location where it is available _once_ and update the information there.

Killfile me.  I'm posting far less noise to lkml per month than 
your daily line count of repetitive, non-informational space 
wasting dot_sig.

Thanks,
Grant.

