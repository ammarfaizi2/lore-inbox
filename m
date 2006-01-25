Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbWAYRVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWAYRVj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 12:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbWAYRVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 12:21:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8846 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750979AbWAYRVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 12:21:38 -0500
Date: Wed, 25 Jan 2006 09:21:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alexander Gran <alex@zodiac.dnsalias.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm3
Message-Id: <20060125092117.03c69174.akpm@osdl.org>
In-Reply-To: <200601251448.20664@zodiac.zodiac.dnsalias.org>
References: <200601251448.20664@zodiac.zodiac.dnsalias.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Gran <alex@zodiac.dnsalias.org> wrote:
>
> Hi,
> 
> mm3 is basically running ok, however it has one problem (that ocurs in mm2, 
> too):
> My Netbeans (java-ide) debugger is to slow. It takes some ms (up to 1000 I'd 
> think) to step over one line, in 13-rc2-mm1 I cannot realize a delay at all.
> Any Idea how to profile the kernel/my system to get an Idea. Everything else 
> (C, C++, java apps..) are running fine.
> 

Strange.   It might be worth checking 2.6.16-rc1-git4.

If the CPU load is high (ie: 100%) during the delay, and it's mostly system
time then yes, a kernel profile would be interesting. 
Documentation/basic_profiling.txt has details.  
