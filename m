Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263436AbTJQObQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 10:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263438AbTJQObQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 10:31:16 -0400
Received: from mail-3.tiscali.it ([195.130.225.149]:48777 "EHLO
	mail-3.tiscali.it") by vger.kernel.org with ESMTP id S263436AbTJQObP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 10:31:15 -0400
Date: Fri, 17 Oct 2003 16:26:35 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: "Carlo E. Prelz" <fluido@fluido.as>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: FBDEV 2.6.0-test7 updates.
Message-ID: <20031017142635.GA463@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20031015162056.018737f1.akpm@osdl.org> <Pine.LNX.4.44.0310160022210.13660-100000@phoenix.infradead.org> <20031016091918.GA1002@casa.fluido.as> <1066298431.1407.119.camel@gaston> <20031016101905.GA7454@casa.fluido.as> <1066300935.646.136.camel@gaston> <20031017100412.GA1639@casa.fluido.as>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031017100412.GA1639@casa.fluido.as>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Fri, Oct 17, 2003 at 12:04:12PM +0200, Carlo E. Prelz ha scritto: 
> Then, when changing to 1280x1024, with command
> 
> /usr/sbin/fbset  -depth 32 1280x1024-60

fbset doesn't work with linux 2.6.

> Obviously, if I were able to set the default mode to 1280x1024, things
> would be sunny.
> video=radeonfb:1280x1024-32@60 
> and
> video=radeonfb:mode:1280x1024-32@60 
> seems not to produce any visible effect. What is the current proper
> way to initialize radeonfb from LILO?

video=radeonfb radeonfb.mode_option=1280x1024-32@60

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
You and me baby ain't nothin' but mammals
So let's do it like they do on the Discovery Channel
