Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965116AbVHJOEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965116AbVHJOEp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 10:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965117AbVHJOEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 10:04:45 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:45492 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965116AbVHJOEo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 10:04:44 -0400
Date: Wed, 10 Aug 2005 19:35:28 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: George Anzinger <george@mvista.com>
Cc: Con Kolivas <kernel@kolivas.org>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, ck@vds.kolivas.org, tony@atomide.com,
       tuukka.tikkanen@elektrobit.com, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 5
Message-ID: <20050810140528.GA20893@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <200508031559.24704.kernel@kolivas.org> <200508060239.41646.kernel@kolivas.org> <20050806174739.GU4029@stusta.de> <200508071512.22668.kernel@kolivas.org> <20050807165833.GA13918@in.ibm.com> <42F905DA.4070308@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42F905DA.4070308@mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2005 at 12:36:58PM -0700, George Anzinger wrote:
> IMNOHO, this is the ONLY way to keep proper time.  As soon as you 
> reprogram the PIT you have lost track of the time.

George,
	Can't TSC (or equivalent) serve as a backup while PIT is disabled,
especially considering that we disable PIT only for short duration 
in practice (few seconds maybe) _and_ that we don't have HRT support yet?

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
