Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292458AbSB0OFy>; Wed, 27 Feb 2002 09:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292464AbSB0OFe>; Wed, 27 Feb 2002 09:05:34 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:6066 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S292458AbSB0OFX>; Wed, 27 Feb 2002 09:05:23 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200202271405.g1RE5EK15866@devserv.devel.redhat.com>
Subject: Re: [PATCH] kernel 2.5.5 - coredump sysctl
To: msinz@wgate.com (Michael Sinz)
Date: Wed, 27 Feb 2002 09:05:14 -0500 (EST)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
In-Reply-To: <3C7CE025.15DD5CD4@wgate.com> from "Michael Sinz" at Feb 27, 2002 08:33:25 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> BTW - are you looking at merging this into your tree (2.5 and/or 2.4)?
> I belive I can continue doing the patching here but it would be nice
> to have this generally available as some people (consulting clients of mine)
> don't want to run kernels that I build but only ones from RedHat...

I still can't decide if its worth the extra complexity.

I don't btw think the '/' is a big problem - only root can set the core
dump path, and current->comm is the "true" name of the program so won't
have a / in it

