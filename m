Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbUBYX2R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 18:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbUBYXYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 18:24:55 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:34810 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261767AbUBYXYD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 18:24:03 -0500
Message-ID: <403D2E88.2030108@mvista.com>
Date: Wed, 25 Feb 2004 15:23:52 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: kernel list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>,
       "Amit S. Kale" <amitkale@emsyssoft.com>,
       kgdb-bugreport@lists.sourceforge.net
Subject: Re: [Kgdb-bugreport] [PATCH][2/3] Update CVS KGDB's have kgdb_{schedule,process}_breakpoint
References: <20040225213626.GF1052@smtp.west.cox.net> <20040225214343.GG1052@smtp.west.cox.net> <403D28E5.1060701@mvista.com> <20040225230402.GM1052@smtp.west.cox.net>
In-Reply-To: <20040225230402.GM1052@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> On Wed, Feb 25, 2004 at 02:59:49PM -0800, George Anzinger wrote:
> 
> 
>>If you are always inserting after irq_exit(), why not modify irq_exit()?  
>>Makes a cleaner patch.
> 
> 
> irq_exit() is in <asm/hardirq.h>, so it doesn't buy us anything in terms
> of files modified.
> 
Ok.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

