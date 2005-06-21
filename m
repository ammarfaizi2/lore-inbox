Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbVFUIbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbVFUIbE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 04:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbVFUISu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 04:18:50 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30364 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261332AbVFUHla (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 03:41:30 -0400
Date: Tue, 21 Jun 2005 09:41:14 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Roy Keene <rkeene@psislidell.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Erik Slagter <erik@slagter.name>,
       linux-kernel@vger.kernel.org
Subject: Re: Problem with 2.6 kernel and lots of I/O
Message-ID: <20050621074114.GA1953@elf.ucw.cz>
References: <Pine.LNX.4.62.0505311042470.7546@hammer.psislidell.com> <20050601195922.GA589@openzaurus.ucw.cz> <1117966262.5027.9.camel@localhost.localdomain> <AF6BB031-9221-4BA3-AFC9-7D167EBE866C@mac.com> <Pine.LNX.4.62.0506201711090.3592@hammer.psislidell.com> <6DCC9CC1-2B5C-430F-96AC-F36477AC8290@mac.com> <Pine.LNX.4.62.0506201848500.2736@hammer.psislidell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0506201848500.2736@hammer.psislidell.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> But the problem doesn't occur with the "local" end, it's with the 
> "recieving" end (which may be the same thing, but mostly it's not, since I 
> tend to reboot the secondary node more).
> 
> The problem occurs on the node running `nbd-server' in userspace and not 
> nessicarily having "nbd" support.

nbd-server is nice and simple userland application, doing no magic. If
that makes machine unusable... well, fix the machine ;-). It may me mm
problem or something... It is basically not nbd related. [Remember,
nbd-server is just another userland process, "nothing to do with nbd",
nothing special].
									Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
