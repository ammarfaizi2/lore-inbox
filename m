Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262789AbSLEIn0>; Thu, 5 Dec 2002 03:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263039AbSLEIn0>; Thu, 5 Dec 2002 03:43:26 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:54945 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S262789AbSLEInZ>; Thu, 5 Dec 2002 03:43:25 -0500
Date: Thu, 5 Dec 2002 09:18:50 +0100
From: Dominik Brodowski <linux@brodo.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Bishop Brock <bcbrock@us.ibm.com>, linux-kernel@vger.kernel.org,
       cpufreq@www.linux.org.uk, linux-pm-devel@lists.sourceforge.net
Subject: Re: [Linux-pm-devel] Re: IBM/MontaVista Dynamic Power Management Project
Message-ID: <20021205081850.GA1178@brodo.de>
References: <OF6879354C.0478D137-ON86256C84.005CA3C0@pok.ibm.com> <1038938270.28176.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1038938270.28176.2.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2002 at 06:57:49PM +0100, Arjan van de Ven wrote:
> On Tue, 2002-12-03 at 18:46, Bishop Brock wrote:
> > IBM and MontaVista have initiated a joint project to develop a
> > dynamic power management control and policy mechanism for Linux
> > for processors supporting dynamic voltage and frequency scaling.
> > A paper describing the proposal can be obtained from
> > 
> > http://www.research.ibm.com/arl/projects/dpm.html
> > 
> > A working prototype of the proposed framework for
> > the IBM PowerPC 405LP processor exists and will be made
> > public in the near future.
> 
> any idea if/how this will fit into the existing cross platform cpufreq
> framework ?

Actually, if I understand IBM's proposal right, it seems to be an
alternative to cpufreq: a different "mid-layer" between the low-level
processor drivers, other kernel code, and the user. So it's not an extension
to an existing feature, but a new feature - Halloween was some weeks ago...

	Dominik
