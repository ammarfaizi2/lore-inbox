Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264098AbUIZV7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbUIZV7v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 17:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbUIZV7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 17:59:51 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:21203 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S264098AbUIZV7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 17:59:47 -0400
Subject: Re: 2.6.9-rc2-mm1 swsusp bug report.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@suse.cz>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Kevin Fenzi <kevin@scrye.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040926100442.GG10435@elf.ucw.cz>
References: <20040924021956.98FB5A315A@voldemort.scrye.com>
	 <20040924143714.GA826@openzaurus.ucw.cz>
	 <20040924210958.A3C5AA2073@voldemort.scrye.com>
	 <1096069216.3591.16.camel@desktop.cunninghams>
	 <20040925014546.200828E71E@voldemort.scrye.com>
	 <1096113235.5937.3.camel@desktop.cunninghams>
	 <415562FE.3080709@yahoo.com.au> <20040925154527.GA8212@elf.ucw.cz>
	 <1096149821.8359.1.camel@desktop.cunninghams>
	 <20040926100442.GG10435@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1096235982.10015.1.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 27 Sep 2004 07:59:42 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sun, 2004-09-26 at 20:04, Pavel Machek wrote:
> > Are we still planning on having suspend2 replace swsusp eventually? It
> > was a lot of work to switch from those high order allocations, and if we
> > are still going to replace swsusp, perhaps it's would be a better use of
> > your time to do other things?
> 
> I do not know if I'm more scared of swsusp1 to kill order-8
> allocations or if suspend2's two page sets scare me more. (Hooks
> suspend2 needs to stop all page cache activity are scary...)

Hooks to stop all page cache activity? I'm not sure what you mean.

> I certainly want some parts of suspend2 (like improved freezer, if it
> can be made small enough), but I'm no longer sure I want all of it. I
> expected many people complaining about highmem problems in swsusp1,
> and that just did not happen; SMP support turned out to be reasonably
> simple...

Okay. There are other advantages too, of course :>

Nigel

