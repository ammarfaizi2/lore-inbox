Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277010AbRJKWW3>; Thu, 11 Oct 2001 18:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276997AbRJKWWT>; Thu, 11 Oct 2001 18:22:19 -0400
Received: from smi-105.smith.uml.edu ([129.63.206.105]:32520 "HELO
	buick.pennace.org") by vger.kernel.org with SMTP id <S276966AbRJKWWF>;
	Thu, 11 Oct 2001 18:22:05 -0400
Date: Thu, 11 Oct 2001 18:19:51 -0400
From: Alex Pennace <alex@pennace.org>
To: Christopher Friesen <cfriesen@nortelnetworks.com>
Cc: James Sutherland <jas88@cam.ac.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: unkillable process in R state?
Message-ID: <20011011181951.A21719@buick.pennace.org>
Mail-Followup-To: Christopher Friesen <cfriesen@nortelnetworks.com>,
	James Sutherland <jas88@cam.ac.uk>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOL.4.33.0110111918330.24868-100000@orange.csi.cam.ac.uk> <3BC5F0A0.56F644B7@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BC5F0A0.56F644B7@nortelnetworks.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2001 at 03:18:34PM -0400, Christopher Friesen wrote:
> Okay, I just tried this, and the pertinant results were: 
> 
> $ gdb find
> GNU gdb 4.18
> Copyright 1998 Free Software Foundation, Inc.
> GDB is free software, covered by the GNU General Public License, and you are
> welcome to change it and/or distribute copies of it under certain conditions.
> Type "show copying" to see the conditions.
> There is absolutely no warranty for GDB.  Type "show warranty" for details.
> This GDB was configured as "ppc-yellowdog-linux"...(no debugging symbols
> found)...
> (gdb) attach 31075
> Attaching to program: /usr/bin/find, Pid 31075
> 
> 
> 
> At this point it hangs and ctrl-C has no effect and I have to kill it from
> another console.
> 
> Attaching to another program worked fine.
> 
> Any other ideas?

Look in /proc/31075/fd and see what it has open.
