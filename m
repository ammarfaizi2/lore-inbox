Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264886AbUGBTtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264886AbUGBTtT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 15:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264900AbUGBTtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 15:49:19 -0400
Received: from mail.kroah.org ([65.200.24.183]:58326 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264886AbUGBTtS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 15:49:18 -0400
Date: Fri, 2 Jul 2004 12:44:14 -0700
From: Greg KH <greg@kroah.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linas@austin.ibm.com, Hollis Blanchard <hollisb@us.ibm.com>,
       nfont@austin.ibm.com, Paul Mackerras <paulus@samba.org>,
       PPC64 External List <linuxppc64-dev@lists.linuxppc.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.6] PPC64: log firmware errors during boot.
Message-ID: <20040702194413.GA13774@kroah.com>
References: <20040629191046.Q21634@forte.austin.ibm.com> <16610.39955.554139.858593@cargo.ozlabs.ibm.com> <20040701160614.I21634@forte.austin.ibm.com> <16613.15510.325099.273419@cargo.ozlabs.ibm.com> <3EC84E0C-CC32-11D8-BDBD-000A95A0560C@us.ibm.com> <40E58AE9.6050009@austin.ibm.com> <1088789345.26946.9.camel@localhost> <20040702131347.V21634@forte.austin.ibm.com> <20040702182752.GA28825@kroah.com> <1088794548.28076.49.camel@nighthawk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1088794548.28076.49.camel@nighthawk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2004 at 11:55:48AM -0700, Dave Hansen wrote:
> On Fri, 2004-07-02 at 11:27, Greg KH wrote:
> > On Fri, Jul 02, 2004 at 01:13:47PM -0500, linas@austin.ibm.com wrote:
> > > I mis-spoke earlier about who the intendend consumers of the printk'ed
> > > messages are; rtasd already implements its own kernl-to-user interface
> > > via the /proc interface.  Yes, everything in /proc/ppc64 is prolly
> > > deprecated, but lets put this off till later.
> > 
> > Later when?
> 
> 2.7.0, anyone?

Fine with me, Linas?

