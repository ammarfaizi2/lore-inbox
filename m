Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264284AbTDKBP6 (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 21:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264283AbTDKBP6 (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 21:15:58 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:4312 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264281AbTDKBP5 convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 21:15:57 -0400
Content-Type: text/plain; charset=US-ASCII
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [patch for playing] Patch to support 4000 disks and maintain backward compatibility
Date: Thu, 10 Apr 2003 18:25:12 -0700
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org, <linux-scsi@vger.kernel.org>
References: <200304101339.49895.pbadari@us.ibm.com> <Pine.LNX.4.44.0304110157460.12110-100000@serv>
In-Reply-To: <Pine.LNX.4.44.0304110157460.12110-100000@serv>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304101825.12299.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 April 2003 05:08 pm, Roman Zippel wrote:
> Hi,
>
> On Thu, 10 Apr 2003, Badari Pulavarty wrote:
> > This patch addresses the backward compatibility with device nodes
> > issue. All the new disks will be addressed by only last major.
>
> This nicely demonstrates, that it's not exactly becoming nicer, when one
> has to deal with compatibility. This is one more reason to at least
> consider a more general solution, from which all drivers can benefit from.

I am all for more general solution (dynamic assignment), if I can get

(1) backward compatibility with device nodes
(2) device nodes get updated automagically whenever my
<major,minor> changes. (may be due to insmod/rmmod, reboot etc..)

I can't see (2) happening easily. I know that Greg KH is working on
udev (/dev/ memory filesystem). Once that happens, we have to change
drivers/subsystems (we need) to make dynamic allocation. All of this Is 
going to happen for 2.6 ?

Thats why, I am trying to come out with half-cooked workable solution for 2.6. 

Thanks,
Badari
