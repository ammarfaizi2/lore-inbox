Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263879AbTCUTiM>; Fri, 21 Mar 2003 14:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263874AbTCUTiK>; Fri, 21 Mar 2003 14:38:10 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:1186 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S263838AbTCUTfq>; Fri, 21 Mar 2003 14:35:46 -0500
Date: Fri, 21 Mar 2003 11:46:17 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: george anzinger <george@mvista.com>
Cc: Martin Waitz <tali@admingilde.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Clock monotonic  a suggestion
Message-ID: <20030321194616.GD31586@ca-server1.us.oracle.com>
References: <3E7A59CD.8040700@mvista.com> <20030321131744.GL27366@admingilde.org> <3E7B659F.9020407@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E7B659F.9020407@mvista.com>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 21, 2003 at 11:18:55AM -0800, george anzinger wrote:
> I don't really understand how :(
> 
> I want a tick on CLOCK_MONOTONIC to be the same size as a tick on 
> gettimeofday() over the life of the system.  I.e. lock step.  The only 

	Ok, I think we're having a terminology problem here.  I wasn't
aware that "CLOCK_MONOTONIC" was a POSIX thing, I merely thought you
were speaking of a kconf define for the proposed monotonic_clock()
interface.  That interface is a portable and consistent wrapper around
access to things like the TSC and the cyclone timer.  Maybe it needs
renaming.

Joel

-- 

"But all my words come back to me
 In shades of mediocrity.
 Like emptiness in harmony
 I need someone to comfort me."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
