Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030611AbWF0Cmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030611AbWF0Cmv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 22:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030609AbWF0Cmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 22:42:50 -0400
Received: from koto.vergenet.net ([210.128.90.7]:16578 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S933331AbWF0Cmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 22:42:47 -0400
Date: Tue, 27 Jun 2006 11:30:48 +0900
From: Horms <horms@verge.net.au>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       Neela.Kolli@engenio.com, linux-scsi@vger.kernel.org, mike.miller@hp.com,
       "Zou, Nanhai" <nanhai.zou@intel.com>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [RFC] [PATCH 2/2] kdump: cciss driver initialization?issue fix
Message-ID: <20060627023048.GJ2956@verge.net.au>
References: <m1veqqxyrb.fsf@ebiederm.dsl.xmission.com> <20060626090915.CA8333402A@koto.vergenet.net> <20060626134536.GB8985@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060626134536.GB8985@in.ibm.com>
X-Cluestick: seven
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 09:45:36AM -0400, Vivek Goyal wrote:
> On Mon, Jun 26, 2006 at 06:09:15PM +0900, Horms wrote:
> > In article <m1veqqxyrb.fsf@ebiederm.dsl.xmission.com> you wrote:
> > > 
> > > Not all pci busses support it but there is a standard pci bus reset bit
> > > in pci bridges.
> > > 
> > > I don't know if it would help but it might make sense to have a config
> > > option that can be used to mark drivers that are known to have problems,
> > > in these scenarios.
> > > 
> > > CONFIG_BRITTLE_INIT perhaps?
> > > 
> > > It would at least make it easier for people to see which drivers
> > > they don't want to use, and give people some incentive to fix things.
> > 
> > I believe that MPT Fusion could go on that list.
> > 
> > http://permalink.gmane.org/gmane.linux.ports.ia64/14451
> > 
> >
> 
> Above link does not give details of exact MPT fusion initialization 
> problems faced on IA64. I faced MPT fusion initialization issues on
> i386/x86_64 and posted a fix.
> 
> http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=9bf0a28c9a24e2cee5deecf89d118254374c75ba
> 
> You might want to download and check.

Thanks, I wasn't aware of that. I'll see if that helps on ia64.

-- 
Horms                                           
H: http://www.vergenet.net/~horms/          W: http://www.valinux.co.jp/en/

