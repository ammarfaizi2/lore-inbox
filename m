Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264984AbUGIPdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264984AbUGIPdB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 11:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264997AbUGIPdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 11:33:01 -0400
Received: from nika.frontier.iarc.uaf.edu ([137.229.94.16]:18304 "EHLO
	nika.frontier.iarc.uaf.edu") by vger.kernel.org with ESMTP
	id S264984AbUGIPc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 11:32:58 -0400
Date: Fri, 9 Jul 2004 07:32:57 -0800
From: Christopher Swingley <cswingle@iarc.uaf.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IRQ issues, (nobody cared, disabled), not USB
Message-ID: <20040709153257.GA2363@iarc.uaf.edu>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040708155356.GG22065@iarc.uaf.edu> <20040708220522.73839ea3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040708220522.73839ea3.akpm@osdl.org>
X-gpg-fingerprint: B96C 58DC 0643 F8FE C9D0  8F55 1542 1A4F 0698 252E
X-gpg-key: [http://www.frontier.iarc.uaf.edu/~cswingle/gnupgkey.asc]
X-URL: [http://www.frontier.iarc.uaf.edu/~cswingle/]
X-Editor: VIM [http://www.vim.org]
X-message-flag: Consider Linux: fast, reliable, secure & free!
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

* Andrew Morton <akpm@osdl.org> [2004-Jul-08 21:05 AKDT]:
> Christopher Swingley <cswingle@iarc.uaf.edu> wrote:
> > 
> >  03:27:26 kernel: irq 7: nobody cared!
> > ...
> > I've tried booting without ACPI, and I've tried an eepro100 card 
> > instead of the 8139too that's causing the error above.
> 
> hmm, so the eepro100 failed in the same way as the rtl8139?

Yes indeed.  I had the eepro100 in there initially and after it started 
dropping out, I figured I'd see if an 8139too would (I know it sounds 
odd. . .) work better.

> It would be useful if you could go back to 2.6.5 for a while, so we 
> can mostly-eliminate a hardware glitch.

I'm back in 2.6.5 now.  Any other tests I can perform to help eliminate 
the potential for a hardware problem?  The timing of the failure is so 
irregular that it would seem to point to a hardware flaw, but who knows.

I can no longer recall when this first started happening, but there's a 
good chance this happened when I was running 2.6.5 too.  I track the 
vanilla releases pretty closely.

Thanks,

Chris
-- 
Christopher S. Swingley          email: cswingle@iarc.uaf.edu (work)
Intl. Arctic Research Center            cswingle@gmail.com (personal)
University of Alaska Fairbanks   www.frontier.iarc.uaf.edu/~cswingle/

