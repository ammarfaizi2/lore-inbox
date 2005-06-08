Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbVFHUui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbVFHUui (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 16:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbVFHUuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 16:50:37 -0400
Received: from ns1.suse.de ([195.135.220.2]:23182 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261612AbVFHUuV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 16:50:21 -0400
From: Marcus Meissner <meissner@suse.de>
To: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc64: Fix PER_LINUX32 behaviour
In-Reply-To: <20050608.121950.104038734.davem@davemloft.net.suse.lists.linux.kernel>
X-Newsgroups: suse.lists.linux.kernel
User-Agent: tin/1.6.2-20030910 ("Pabbay") (UNIX) (Linux/2.6.11.10-3-ppc64 (ppc64))
Message-Id: <20050608205017.861757D1D4@grape.suse.de>
Date: Wed,  8 Jun 2005 22:50:17 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20050608.121950.104038734.davem@davemloft.net.suse.lists.linux.kernel> you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Wed, 8 Jun 2005 20:49:48 +0200
> 
>> With the LINUX32 personality, you can build 32 bit binaries through
>> autoconf, rpmbuild, or the kernel without pretending to be
>> cross-compiling. It may not be the best solution, but people seem to
>> rely on it and the patch brings ppc64 in line with how it works on
>> the other architectures.
> 
> I totally agree, this has a large precedence on many platforms
> and there are even gcc frontends that check the uname output
> to decide what code model to output by default.

Actually what you then do (which is the standard way) is

powerpc32 bash --login

which gives you a shell with 32bit personality and work from
this.

Ciao, Marcus
