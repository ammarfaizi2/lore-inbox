Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264965AbUFGSDD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264965AbUFGSDD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 14:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264964AbUFGSAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 14:00:52 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:57094 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S264966AbUFGSAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 14:00:02 -0400
Message-ID: <40C4B09B.406@techsource.com>
Date: Mon, 07 Jun 2004 14:14:51 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
CC: Arjan van de Ven <arjanv@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 4k stacks in 2.6
References: <Pine.LNX.4.44.0405251549530.26157-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.44.0405251607520.26157-100000@chimarrao.boston.redhat.com> <20040525211522.GF29378@dualathlon.random> <20040526103303.GA7008@elte.hu> <20040526125014.GE12142@wohnheim.fh-wedel.de> <20040526125300.GA18028@devserv.devel.redhat.com> <20040526130047.GF12142@wohnheim.fh-wedel.de>
In-Reply-To: <20040526130047.GF12142@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jörn Engel wrote:

> But I'll shut up now and see if I can generate better data over the
> weekend.  -test11 still had fun stuff like 3k stack consumption over
> some code paths in a pretty minimal kernel.  Wonder what 2.6.6 will do
> with allyesconfig. ;)

That gave me an idea.  Sometimes in chip design, we 'overconstrain' the 
logic synthesizer, because static timing analyzers often produce 
inaccurate results.  Anyhow, what if we were to go to 4K stacks but in 
static code analysis, flag anything which uses more than 2K or even 1K?

