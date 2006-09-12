Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030344AbWILS2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030344AbWILS2e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 14:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030350AbWILS2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 14:28:33 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:51118 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1030344AbWILS2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 14:28:32 -0400
Message-ID: <4506FC2D.2070109@oracle.com>
Date: Tue, 12 Sep 2006 11:27:57 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Frederik Deweerdt <deweerdt@free.fr>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rmk+kernel@arm.linux.org.uk
Subject: Re: [-mm patch] arm build fail: vfpsingle.c
References: <20060912000618.a2e2afc0.akpm@osdl.org> <20060912200522.GN3775@slug>
In-Reply-To: <20060912200522.GN3775@slug>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frederik Deweerdt wrote:
> On Tue, Sep 12, 2006 at 12:06:18AM -0700, Andrew Morton wrote:
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm2/
>>
> Hi,
> 
> It looks like Zach Brown's patch pr_debug-check-pr_debug-arguments
> worked as inteded.

:).  I should really take the time to get some cross compilers going.

>   arch/arm/vfp/vfpsingle.c:201: error: `func' undeclared (first use in
>   this function)

Does changing 'func' to '__func__' in the arguments fix it?

- z
