Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbTKNP2e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 10:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbTKNP2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 10:28:34 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:42423
	"EHLO x30.random") by vger.kernel.org with ESMTP id S262730AbTKNP2d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 10:28:33 -0500
Date: Fri, 14 Nov 2003 16:28:05 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Larry McVoy <lm@work.bitmover.com>, "H. Peter Anvin" <hpa@zytor.com>,
       Davide Libenzi <davidel@xmailserver.org>, Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
Message-ID: <20031114152805.GC6733@x30.random>
References: <3FAFD1E5.5070309@zytor.com> <Pine.LNX.4.44.0311101004150.2097-100000@bigblue.dev.mdolabs.com> <20031110183722.GE6834@x30.random> <3FAFE22B.3030108@zytor.com> <20031110193101.GF6834@x30.random> <20031114051300.GA3466@pimlott.net> <20031114140124.GQ1649@x30.random> <20031114145332.GA30711@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031114145332.GA30711@work.bitmover.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 14, 2003 at 06:53:33AM -0800, Larry McVoy wrote:
> Rsync coherence is your problem, there is nothing I can do about that,
> I don't admin kernel.org.  Peter has a login on kernel.bkbits.net and
> we can coordinate so he gets a coherent snapshot.  It's trivial, he
> could sync the data to kernel.org at 2PM and we update the data at 2AM,
> I tend to think that there won't be any coherency problems.

if we know rsync.kernel.org is getting the update at 2PM we can safely
fetch it from kernel.org at 2AM. It's not very robust and it would be
hard to enforce it with the mirrors, but it should work and it's much
better than nothing ;).
