Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264454AbUASXkq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 18:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264434AbUASXkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 18:40:46 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:13750 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264454AbUASXko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 18:40:44 -0500
Subject: Re: Help port swsusp to ppc.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: ncunningham@users.sourceforge.net, Hugang <hugang@soulinfo.com>,
       ncunningham@clear.net.nz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       debian-powerpc@lists.debian.org
In-Reply-To: <20040119204551.GB380@elf.ucw.cz>
References: <20040119105237.62a43f65@localhost>
	 <1074483354.10595.5.camel@gaston> <1074489645.2111.8.camel@laptop-linux>
	 <1074490463.10595.16.camel@gaston>  <20040119204551.GB380@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1074555531.10595.89.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 20 Jan 2004 10:38:52 +1100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Well, then what you do is not swsusp.
> 
> swsusp does assume same kernel during suspend and resume. Doing resume
> within bootloader (and thus avoiding this) would be completely
> different design.

Wait... what the hell in swsusp requires this assumption ? It seems to
me like a completely unnecessary design limitation.

Ben.


