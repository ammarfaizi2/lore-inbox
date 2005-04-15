Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbVDOTWC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbVDOTWC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 15:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVDOTWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 15:22:01 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:64718 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261932AbVDOTV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 15:21:56 -0400
Subject: Re: Kernel Rootkits
From: Lee Revell <rlrevell@joe-job.com>
To: Daniel Souza <thehazard@gmail.com>
Cc: Allison <fireflyblue@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <e1e1d5f40504151140411a3387@mail.gmail.com>
References: <17d79880504151115744c47bd@mail.gmail.com>
	 <e1e1d5f40504151140411a3387@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 15 Apr 2005 15:21:55 -0400
Message-Id: <1113592915.23839.6.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-15 at 11:40 -0700, Daniel Souza wrote:
> A way to "protect" system calls is, after boot a trusted kernel image,
> take a MD5 of the syscalls functions implementations (the opcodes that
> are part of sys_read for example) and store it in a secure place.

That's the problem, once the kernel is compromised there's no such thing
as a secure place.  Solving this problem requires things like "trusted
computing" aka hardware support.

Lee

