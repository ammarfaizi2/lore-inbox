Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293469AbSCASTo>; Fri, 1 Mar 2002 13:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293478AbSCASTd>; Fri, 1 Mar 2002 13:19:33 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:19632 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S293469AbSCASTX>; Fri, 1 Mar 2002 13:19:23 -0500
Date: Fri, 01 Mar 2002 12:19:21 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.19-pre2] Make max_threads be based on normal zone
 size
Message-ID: <86950000.1015006761@baldur>
In-Reply-To: <p73vgcgjgtq.fsf@oldwotan.suse.de>
In-Reply-To: <71650000.1015004327@baldur.suse.lists.linux.kernel>
 <p73vgcgjgtq.fsf@oldwotan.suse.de>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Friday, March 01, 2002 19:14:41 +0100 Andi Kleen <ak@suse.de> wrote:

> There are lots of other functions with the same problem (like all the 
> hash table sizing and others). Perhaps these should be fixed too? 

I coded the patch in a fashion that makes both total physical memory and
mapped physical memory size available, specifically so other people could
change places that might also have the same problem.  I guessed there might
be some.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

