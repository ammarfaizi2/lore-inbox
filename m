Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267340AbUG1RMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267340AbUG1RMi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 13:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267344AbUG1RMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 13:12:37 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:59833 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S267340AbUG1RKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 13:10:17 -0400
Date: Wed, 28 Jul 2004 19:09:20 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, suparna@in.ibm.com,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@osdl.org>, fastboot@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
Message-ID: <20040728170920.GP15895@dualathlon.random>
References: <16734.1090513167@ocs3.ocs.com.au> <20040725235705.57b804cc.akpm@osdl.org> <m1r7qw7v9e.fsf@ebiederm.dsl.xmission.com> <20040728105455.GA11282@in.ibm.com> <1091011565.30404.0.camel@localhost.localdomain> <35040000.1091025526@[10.10.2.4]> <1091023585.30740.7.camel@localhost.localdomain> <120130000.1091028085@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <120130000.1091028085@[10.10.2.4]>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 08:21:26AM -0700, Martin J. Bligh wrote:
> --Alan Cox <alan@lxorguk.ukuu.org.uk> wrote (on Wednesday, July 28, 2004 15:06:27 +0100):
> 
> > On Mer, 2004-07-28 at 15:38, Martin J. Bligh wrote:
> >> After kexec, we shouldn't need such things, do we? Before it, Linus won't 
> >> take the patch, as he said he doesn't like systems in unstable states doing
> >> crashdumps to disk ...
> > 
> > And what does kexec do.. it accesses the disk. A SHA signed standalone
> > dumper is as safe as anything else if not safer.
> 
> But it's reading, not writing ... personally I'm happier with that bit ;-)

I was using mcore a few years back and it didn't need to read anything
to launch the new kernel image with bootimg, the new kernel image was
stored in a safe place in memory IIRC
