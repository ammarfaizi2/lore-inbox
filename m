Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137207AbREKSvI>; Fri, 11 May 2001 14:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137209AbREKSu7>; Fri, 11 May 2001 14:50:59 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:35340 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S137207AbREKSut>; Fri, 11 May 2001 14:50:49 -0400
Subject: Re: 2.4.4 kernel freeze for unknown reason
To: linuxkernel@AdvancedResearch.org (Vincent Stemen)
Date: Fri, 11 May 2001 19:46:48 +0100 (BST)
Cc: jq419@my-deja.com (Jacky Liu), linux-kernel@vger.kernel.org
In-Reply-To: <01051113452400.07411@quark> from "Vincent Stemen" at May 11, 2001 01:45:24 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14yHw8-0001V8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have been monitoring the memory usage constantly with the gnome
> memory usage meter and noticed that as swap grows it is never freed
> back up.  I can kill off most of the large applications, such as

The swap handling in 2.4 is somewhat hosed at the moment.

> If I turn swap off all together or turn it off and back on
> periodically to clear the swap before it gets full, I do not seem to
> experience the lockups.

That sounds right. I can give you a tiny patch that should fix the lockups
and instead it will kill processes out of memory but thats obviously not
the actual fix 8)


