Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbTIZHeP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 03:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbTIZHeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 03:34:15 -0400
Received: from adsl173-178.dsl.uva.nl ([146.50.173.178]:41911 "EHLO
	hypnos.var.cx") by vger.kernel.org with ESMTP id S261973AbTIZHeO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 03:34:14 -0400
Date: Fri, 26 Sep 2003 09:34:07 +0200
From: Frank v Waveren <fvw@var.cx>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Kernel Developer List <linux-kernel@vger.kernel.org>
Subject: Re: How do I access ioports from userspace?
Message-ID: <20030926073407.GA15797@var.cx>
References: <20030925160351.E26493@one-eyed-alien.net> <20030926052636.GA15006@var.cx> <1064561225.28616.15.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1064561225.28616.15.camel@gaston>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 26, 2003 at 09:27:05AM +0200, Benjamin Herrenschmidt wrote:
> Simple note: the above will work on x86 only...
in[bwl]/out[bwl] are available on a lot more than just x86. Mind you, the
mechanisms are subtly different. Then again, if you're using direct hardware
access you're not going for portability anyway.

-- 
Frank v Waveren                                      Fingerprint: 21A7 C7F3
fvw@[var.cx|stack.nl|dse.nl] ICQ#10074100               1FF3 47FF 545C CB53
Public key: hkp://wwwkeys.pgp.net/fvw@var.cx            7BD9 09C0 3AC1 6DF2
