Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263055AbTEYQeC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 12:34:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263270AbTEYQeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 12:34:02 -0400
Received: from main.gmane.org ([80.91.224.249]:58242 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263055AbTEYQeB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 12:34:01 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Nicholas Wourms <nwourms@myrealbox.com>
Subject: Re: 2.5.69-mm9
Date: Sun, 25 May 2003 12:47:08 -0400
Message-ID: <3ED0F38C.5020203@myrealbox.com>
References: <20030525042759.6edacd62.akpm@digeo.com> <200305251456.39404.rudmer@legolas.dynup.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
Cc: linux-mm@kvack.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rudmer van Dijk wrote:
> On Sunday 25 May 2003 13:27, Andrew Morton wrote:
> 
>>. 2.5.69-mm9 is not for the timid.  It includes extensive changes to the
>>  ext3 filesystem and the JBD layer.  It withstood an hour of testing on my
>>  4-way, but it probably has a couple of holes still.
> 
> 
> there seems to be no problem, it survives a kernel compile.
> Only the patch for fs/buffer.c seems to be reverted, it was there in -mm8
> (original patch by wli, adjusted to cleanly apply against -mm9)
> 
> 	Rudmer
> 

It looks like he "silently" updated aio-06-bread_wq-fix.patch with an 
additional fix, but it overwrote the existing diffs in that file.

Cheers,
Nicholas


