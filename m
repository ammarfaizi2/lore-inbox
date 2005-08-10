Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932583AbVHJWnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbVHJWnK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 18:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbVHJWnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 18:43:09 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:9969 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932583AbVHJWnI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 18:43:08 -0400
Message-ID: <42FA8270.50105@mvista.com>
Date: Wed, 10 Aug 2005 15:40:48 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tony Lindgren <tony@atomide.com>
CC: Srivatsa Vaddagiri <vatsa@in.ibm.com>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org, ck@vds.kolivas.org,
       tuukka.tikkanen@elektrobit.com, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 3
References: <200508031559.24704.kernel@kolivas.org> <20050805123754.GA1262@in.ibm.com> <20050808072600.GE28070@atomide.com> <42F90C78.60500@mvista.com> <20050810080246.GB4140@atomide.com>
In-Reply-To: <20050810080246.GB4140@atomide.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Lindgren wrote:
~
> Do you have a patch around for improving next_timer_interrupt()?
> 
Well, sort of.  The code in the VST patch does the right thing.  Problem 
is it does a bit more than the timer.c code.  You can find that code on 
the HRT site CVS.
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
