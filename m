Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267209AbUG1PJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267209AbUG1PJT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 11:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267211AbUG1PJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 11:09:19 -0400
Received: from the-village.bc.nu ([81.2.110.252]:19351 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267209AbUG1PJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 11:09:15 -0400
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: suparna@in.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@osdl.org>, fastboot@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <35040000.1091025526@[10.10.2.4]>
References: <16734.1090513167@ocs3.ocs.com.au>
	 <20040725235705.57b804cc.akpm@osdl.org>
	 <m1r7qw7v9e.fsf@ebiederm.dsl.xmission.com>
	 <20040728105455.GA11282@in.ibm.com>
	 <1091011565.30404.0.camel@localhost.localdomain>
	 <35040000.1091025526@[10.10.2.4]>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091023585.30740.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 28 Jul 2004 15:06:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-07-28 at 15:38, Martin J. Bligh wrote:
> After kexec, we shouldn't need such things, do we? Before it, Linus won't 
> take the patch, as he said he doesn't like systems in unstable states doing
> crashdumps to disk ...

And what does kexec do.. it accesses the disk. A SHA signed standalone
dumper is as safe as anything else if not safer.

Alan

