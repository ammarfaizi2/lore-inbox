Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262273AbUKWKoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbUKWKoI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 05:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbUKWKoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 05:44:07 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:28601 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S262273AbUKWKn4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 05:43:56 -0500
Message-ID: <41A3147F.5030409@verizon.net>
Date: Tue, 23 Nov 2004 05:44:15 -0500
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Adrian Bunk <bunk@stusta.de>, rusty@rustcorp.com.au,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] MODULE_PARM_: remove the __deprecated
References: <20041122155619.GG19419@stusta.de> <1101188636.4245.2.camel@krustophenia.net>
In-Reply-To: <1101188636.4245.2.camel@krustophenia.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [209.158.220.243] at Tue, 23 Nov 2004 04:43:53 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Mon, 2004-11-22 at 16:56 +0100, Adrian Bunk wrote:
> 
>>MODULE_PARM_ might be deprecated.
>>But there are still over 2000 places in the kernel where it's used.
> 
> 
> Changing MODULE_PARM to module_param is not exactly rocket science.  You
> could probably fix them all with a perl script.
> 
> Lee
> 

Not really.  The permissions for the sysfs files, if nothing else, have to be done 
manually.  Plus, check out:

http://lists.osdl.org/pipermail/kernel-janitors/2004-November/002559.html

and

http://lists.osdl.org/pipermail/kernel-janitors/2004-November/002592.html

for two examples of the kinds of problems that a script would run into.  Not 
rocket science, but it can be tricky.

Jim
