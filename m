Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263052AbTI3AZU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 20:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263055AbTI3AZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 20:25:20 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:28805 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263052AbTI3AZS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 20:25:18 -0400
Date: Tue, 30 Sep 2003 01:24:58 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Daniel Jacobowitz <dan@debian.org>, Arjan van de Ven <arjanv@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>, Brian Gerst <bgerst@didntduck.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: -mregparm=3 (was  Re: [PATCH] i386 do_machine_check() is redundant.
Message-ID: <20030930002458.GC25485@mail.jlokier.co.uk>
References: <Pine.LNX.4.44.0309281121470.15408-100000@home.osdl.org> <1064775868.5045.4.camel@laptop.fenrus.com> <Pine.LNX.4.58.0309292214100.3276@artax.karlin.mff.cuni.cz> <20030929202604.GA23344@nevyn.them.org> <Pine.LNX.4.58.0309292309050.7824@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0309292309050.7824@artax.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks compiling the kernel with -mregparm=3 should also try
-mregparm=2, -mregparm=1 and combinations with -mrtd if you want to
find the smallest/fastest.

A long time ago, for a game written mostly in C++, I found the sweet
spot at -mregparm=1 -mrtd.

Enjoy,
-- Jamie

