Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262166AbTHaOMP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 10:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262255AbTHaOMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 10:12:15 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:63673 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262166AbTHaOLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 10:11:04 -0400
Subject: Re: Andrea VM changes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Mike Fedyk <mfedyk@matchmail.com>, Antonio Vargas <wind@cocodriloo.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>
In-Reply-To: <20030830231904.GL24409@dualathlon.random>
References: <Pine.LNX.4.55L.0308301248380.31588@freak.distro.conectiva>
	 <Pine.LNX.4.55L.0308301607540.31588@freak.distro.conectiva>
	 <Pine.LNX.4.55L.0308301618500.31588@freak.distro.conectiva>
	 <20030830231904.GL24409@dualathlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062339003.10208.1.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Sun, 31 Aug 2003 15:10:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-08-31 at 00:19, Andrea Arcangeli wrote:
> I've an algorithm that will work, and that will provide very good
> guarantees to kill the "best" task to make the machine usable again,
> with the needed protection against the security DoSes, but it's in
> no-way similar to the current oom killer.

And -ac has trivial code so you can avoid OOM killing every happening,
which is pretty much essential for big servers. Perhaps merging that
as well would be a good idea.

