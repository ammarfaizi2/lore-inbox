Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbTDKVPV (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 17:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbTDKVPU (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 17:15:20 -0400
Received: from inet-mail4.oracle.com ([148.87.2.204]:5076 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id S261783AbTDKVPT (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 17:15:19 -0400
Date: Fri, 11 Apr 2003 08:43:46 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [patch for playing] Patch to support 4000 disks and maintain backward compatibility
Message-ID: <20030411154345.GV31739@ca-server1.us.oracle.com>
References: <200304101339.49895.pbadari@us.ibm.com> <Pine.LNX.4.44.0304110157460.12110-100000@serv> <200304101825.12299.pbadari@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304101825.12299.pbadari@us.ibm.com>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 10, 2003 at 06:25:12PM -0700, Badari Pulavarty wrote:
> I can't see (2) happening easily. I know that Greg KH is working on
> udev (/dev/ memory filesystem). Once that happens, we have to change
> drivers/subsystems (we need) to make dynamic allocation. All of this Is 
> going to happen for 2.6 ?

	Just to be clear, let's not repeat the devfsd fiasco.  If we
have dynamic update of device nodes (we need it), I want it to work with
my /dev on ext3.

Joel

-- 

"You look in her eyes, the music begins to play.
 Hopeless romantics, here we go again."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
