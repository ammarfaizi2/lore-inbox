Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267180AbUG1OjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267180AbUG1OjN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 10:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267182AbUG1OjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 10:39:13 -0400
Received: from jade.spiritone.com ([216.99.193.136]:10448 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S267180AbUG1OjJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 10:39:09 -0400
Date: Wed, 28 Jul 2004 07:38:47 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, suparna@in.ibm.com
cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       fastboot@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
Message-ID: <35040000.1091025526@[10.10.2.4]>
In-Reply-To: <1091011565.30404.0.camel@localhost.localdomain>
References: <16734.1090513167@ocs3.ocs.com.au> <20040725235705.57b804cc.akpm@osdl.org> <m1r7qw7v9e.fsf@ebiederm.dsl.xmission.com> <20040728105455.GA11282@in.ibm.com> <1091011565.30404.0.camel@localhost.localdomain>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Alan Cox <alan@lxorguk.ukuu.org.uk> wrote (on Wednesday, July 28, 2004 11:46:06 +0100):

> On Mer, 2004-07-28 at 11:54, Suparna Bhattacharya wrote:
>> On Tue, Jul 27, 2004 at 07:53:01PM -0600, Eric W. Biederman wrote:
>> > Andrew Morton <akpm@osdl.org> writes:
>> > 
>> > > Keith Owens <kaos@sgi.com> wrote:
>> > > > 
>> > > >  * How do we get a clean API to do polling mode I/O to disk?
>> > > 
>> > > We hope to not have to.  The current plan is to use kexec: at boot time, do
> 
> If you are prepared to say "dump device is IDE" the driver ends up
> pretty tiny - maybe 4K for PIO mode.

After kexec, we shouldn't need such things, do we? Before it, Linus won't 
take the patch, as he said he doesn't like systems in unstable states doing
crashdumps to disk ...

M.

