Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262773AbSITPVU>; Fri, 20 Sep 2002 11:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262774AbSITPVU>; Fri, 20 Sep 2002 11:21:20 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:46600 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S262773AbSITPVT>; Fri, 20 Sep 2002 11:21:19 -0400
Date: Fri, 20 Sep 2002 16:26:18 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: linux-kernel@vger.kernel.org
Subject: Re: do_gettimeofday vs. rdtsc in the scheduler
Message-ID: <20020920152618.GA90329@compsoc.man.ac.uk>
References: <1032305535.7481.204.camel@cog> <20020917.163246.113965700.davem@redhat.com> <20020918015209.B31263@wotan.suse.de> <20020917.164649.110499262.davem@redhat.com> <20020918015838.A6684@wotan.suse.de> <15753.45833.702405.2357@kim.it.uu.se> <1032442039.26712.32.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1032442039.26712.32.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *17sPff-000BUN-00*tkzY24urOBQ* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2002 at 02:27:19PM +0100, Alan Cox wrote:

> > - There are plenty of laptops whose CPUs have local APICs but whose
> >   BIOSen go berserk if you enable it. There are also plenty of laptops
> 
> Frequently because we don't disable it again before any APM calls I
> suspect. When a CPU goes into sleep mode you must disable PMC and local
> apic timer interrupts.

Isn't this exactly what apic_pm_suspend() does ? Or is that in 2.5 only ?

regards
john
-- 
Support the project - http://www.gtonline.net/private/mapp/project/
