Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265276AbTBCVjl>; Mon, 3 Feb 2003 16:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265754AbTBCVjl>; Mon, 3 Feb 2003 16:39:41 -0500
Received: from main.gmane.org ([80.91.224.249]:43653 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S265276AbTBCVjk>;
	Mon, 3 Feb 2003 16:39:40 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: John Goerzen <jgoerzen@complete.org>
Subject: Re: Kernel 2.4.20 panic in scheduler
Date: Mon, 03 Feb 2003 15:48:41 -0600
Organization: Complete.Org
Message-ID: <877kch8286.fsf@christoph.complete.org>
References: <87k7gh85pw.fsf@christoph.complete.org> <20030203133506.A26686@figure1.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@complete.org
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (powerpc-unknown-linux-gnu)
Cancel-Lock: sha1:wcEEtlJ3S5GXV/8nDJgDdSWwC0U=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chris@wirex.com> writes:

>> Today I experienced a kernel panic running kernel 2.4.20 (plus the ctx
>> vserver patch; otherwise vanilla) with a bcm5700 module added in.  It's
>
> Have you tried this without the vserver patch?  Last I looked it touched
> many of the code paths in your trace below.  Also, if possible, set up a
> serial console, it'll be a lot easier to catch the full trace.

Unfortunately, this is on a production server, and such a drastic
change to the configuration is not really possible at the moment.
However, I have gone ahead and sent them this info.  We will see.

I'm already on the serial console option.  Hope to have it soon.

I saw a lot of TCP-related symbols.  Is there any chance that this is
a bug in the bcm5700 module?  Or in the TCP stack?

-- John

