Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292407AbSB0Ndy>; Wed, 27 Feb 2002 08:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292406AbSB0Ndo>; Wed, 27 Feb 2002 08:33:44 -0500
Received: from [66.150.46.254] ([66.150.46.254]:60496 "EHLO mail.tvol.net")
	by vger.kernel.org with ESMTP id <S292408AbSB0Ndb>;
	Wed, 27 Feb 2002 08:33:31 -0500
Message-ID: <3C7CE025.15DD5CD4@wgate.com>
Date: Wed, 27 Feb 2002 08:33:25 -0500
From: Michael Sinz <msinz@wgate.com>
Organization: WorldGate Communications Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; FreeBSD 4.5-STABLE i386)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] kernel 2.5.5 - coredump sysctl
In-Reply-To: <200202211550.g1LFonO07531@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> Ok - yep - I think you are right that its not in fact cleaner

PS - There is also the fact that I am filtering out any "/" characters
just in case someone makes an attempt at doing nasty stuff with the
program name or the host name.

BTW - are you looking at merging this into your tree (2.5 and/or 2.4)?
I belive I can continue doing the patching here but it would be nice
to have this generally available as some people (consulting clients of mine)
don't want to run kernels that I build but only ones from RedHat...

-- 
Michael Sinz ---- Worldgate Communications ---- msinz@wgate.com
A master's secrets are only as good as
	the master's ability to explain them to others.
