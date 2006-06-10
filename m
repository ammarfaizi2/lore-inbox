Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWFJO4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWFJO4v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 10:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWFJO4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 10:56:50 -0400
Received: from dvhart.com ([64.146.134.43]:18073 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751161AbWFJO4u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 10:56:50 -0400
Message-ID: <448ADDA1.7090608@mbligh.org>
Date: Sat, 10 Jun 2006 07:56:33 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Subject: Re: 2.6.16-rc6-mm2
References: <20060609214024.2f7dd72c.akpm@osdl.org>
In-Reply-To: <20060609214024.2f7dd72c.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc6/2.6.17-rc6-mm2/
> 
> 
> - Added the s390 git tree to the -mm lineup, as git-s390.patch (Martin
>   Schwidefsky)
> 
> - ppc64 (on mac g5) fails to boot for me, due to changes in the powerpc tree.

Doesn't even build here.

arch/powerpc/platforms/built-in.o(.text+0x1053c): In function 
`.scanlog_read':
: undefined reference to `.rtas_extended_busy_delay_time'

Config:
http://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/abat/p570
or
http://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/abat/power4


The non-PPC64 machines seem to have done a clean run for the first time
in a while ... yay!

M.
