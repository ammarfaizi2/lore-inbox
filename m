Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbTKHHfK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 02:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbTKHHfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 02:35:10 -0500
Received: from mxsf25.cluster1.charter.net ([209.225.28.225]:48651 "EHLO
	mxsf25.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S261626AbTKHHfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 02:35:05 -0500
Date: Sat, 8 Nov 2003 02:34:09 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: nforce2 random lockups - still no solution ?
Message-ID: <20031108073409.GA7970@forming>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3F95748E.8020202@tuwien.ac.at> <200311060111.06729.vda@port.imtp.ilyichevsk.odessa.ua> <3FAA2653.9020002@tuwien.ac.at> <1068234006.3fabf5162fd7b@horde.sandall.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1068234006.3fabf5162fd7b@horde.sandall.us>
X-Editor: GNU Emacs 21.1
X-Operating-System: Debian GNU/Linux 2.6.0-test9-mm2 i686
X-Processor: Athlon XP 2000+
X-Uptime: 02:30:04 up 11:42,  2 users,  load average: 0.08, 0.02, 0.01
User-Agent: Mutt/1.5.4i
From: Josh McKinney <forming@charter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On approximately Fri, Nov 07, 2003 at 11:40:06AM -0800, Eric Sandall wrote:
> Quoting Samuel Kvasnica <samuel.kvasnica@tuwien.ac.at>:
> > It was local APIC ! After recompiling 2.4.22 without local apic 
> > everything works smoothly since several  weeks. I wonder when there'll 
> > be a kernel
> > patch that really solves these nforce2/amd issues.
> > Sam
> 
> Disabling local APIC on 2.6.0-test9-mm2 also fixes this (I haven't tried on
> earlier kernels).
> 
> -sandalle
> 

I am seeing the same thing here.  Disk activity and APIC don't seem to
do well.  What kind of performance hit if any are we taking by disabling
APIC?

-- 
Josh McKinney		     |	Webmaster: http://joshandangie.org
--------------------------------------------------------------------------
                             | They that can give up essential liberty
Linux, the choice       -o)  | to obtain a little temporary safety deserve 
of the GNU generation    /\  | neither liberty or safety. 
                        _\_v |                          -Benjamin Franklin
