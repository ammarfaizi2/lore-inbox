Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314514AbSHVRDX>; Thu, 22 Aug 2002 13:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314459AbSHVRDX>; Thu, 22 Aug 2002 13:03:23 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:6909 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S314446AbSHVRDW>;
	Thu, 22 Aug 2002 13:03:22 -0400
Message-ID: <3D651A3A.7125243F@mvista.com>
Date: Thu, 22 Aug 2002 10:07:06 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: is kernel compilation supposed to change header file timestamps?
References: <3D65142F.116481FB@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> 
> I noticed the other day that on a kernel compile, the timestamps of some files are changed.  The
> funny thing is that all the changed ones are header files, but not all header files are modified.
> 
> Is this expected behaviour?
> 
Yes, it has to do with how dependencies are propagated from
header file to header file (i.e. where a header file
includes another).  Or, at least, I think this is what is
going on.
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
