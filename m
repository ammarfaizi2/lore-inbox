Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266883AbUG1LtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266883AbUG1LtV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 07:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266884AbUG1LtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 07:49:20 -0400
Received: from the-village.bc.nu ([81.2.110.252]:44437 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266883AbUG1LtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 07:49:11 -0400
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: suparna@in.ibm.com
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       fastboot@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
In-Reply-To: <20040728105455.GA11282@in.ibm.com>
References: <16734.1090513167@ocs3.ocs.com.au>
	 <20040725235705.57b804cc.akpm@osdl.org>
	 <m1r7qw7v9e.fsf@ebiederm.dsl.xmission.com>
	 <20040728105455.GA11282@in.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091011565.30404.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 28 Jul 2004 11:46:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-07-28 at 11:54, Suparna Bhattacharya wrote:
> On Tue, Jul 27, 2004 at 07:53:01PM -0600, Eric W. Biederman wrote:
> > Andrew Morton <akpm@osdl.org> writes:
> > 
> > > Keith Owens <kaos@sgi.com> wrote:
> > > >
> > > >  * How do we get a clean API to do polling mode I/O to disk?
> > > 
> > > We hope to not have to.  The current plan is to use kexec: at boot time, do

If you are prepared to say "dump device is IDE" the driver ends up
pretty tiny - maybe 4K for PIO mode.

