Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbTJXWp4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 18:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbTJXWpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 18:45:55 -0400
Received: from d216-232-206-119.bchsia.telus.net ([216.232.206.119]:55310 "EHLO
	cyclops.implode.net") by vger.kernel.org with ESMTP id S261970AbTJXWoA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 18:44:00 -0400
Date: Fri, 24 Oct 2003 15:43:55 -0700
From: John Wong <kernel@implode.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: via-rhine on 2.4.23-pre6 Too much work at interrupt, status=0x00001000. (fwd)
Message-ID: <20031024224355.GA2826@gambit.implode.net>
References: <20031023042349.GA6861@gambit.implode.net> <Pine.LNX.4.44.0310241101320.1354-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310241101320.1354-100000@logos.cnet>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 24, 2003 at 11:02:30AM -0200, Marcelo Tosatti wrote:
> 
> 
> On Wed, 22 Oct 2003, John Wong wrote:
> 
> > Could the problem detailed in the thread:
> > 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=106687979128274&w=2
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=106688008628516&w=2
> > 
> > with reference to 8390-based drivers affect the via-rhine driver? 
> 
> No this is a different bug.
> 
> In previous message you said 2.4.22 also was spitting "too much work at 
> interrupt". Correct? 

Correct.  2.4.22 had this same problem.

> Which kernel works on this box?

I have never had a kernel that has worked with this box as is.  The
2.4.22 kernel worked fine on the system before I replaced the
motherboard/CPU/RAM.  2.4.22 was compiled with Pentium optimizations for
a Pentium 100 on a 430FX chipset.  2.4.23-pre6 (now pre7) is compiled
with K6 optimizations for a K6 2 500 on a MVP3 chipset.  ACPI was
initially enabled on the 23-preX kernels, but disabled when Jeff
suggested it might have been the problem.  Both systems
used the same OS/harddrive/NICs.

John
