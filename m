Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbTJBQb5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 12:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263394AbTJBQb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 12:31:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:14484 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262493AbTJBQb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 12:31:56 -0400
Date: Thu, 2 Oct 2003 09:23:39 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] export [__]set_special_pids()
Message-Id: <20031002092339.25ae84c0.rddunlap@osdl.org>
In-Reply-To: <20031001220914.7664d6e3.akpm@osdl.org>
References: <20031001214132.5070b6b5.rddunlap@osdl.org>
	<20031001220914.7664d6e3.akpm@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Oct 2003 22:09:14 -0700 Andrew Morton <akpm@osdl.org> wrote:

| "Randy.Dunlap" <rddunlap@osdl.org> wrote:
| >
| > EXPORT [__]set_special_pids(); Ingo added these
| >  		in include/linux/sched.h but didn't export them;
| >  		jffs uses set_special_pids();
| 
| jffs seems to be trying to do daemonize()-by-hand.  It would be better for
| it to get its act together and just call daemonize().

Yes, your patch looks good to me.

| Is anyone actively testing and using jffs in 2.6?  How does one get it
| going with blkmtd??

No idea.

--
~Randy
