Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262159AbTHYThN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 15:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbTHYThN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 15:37:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:6107 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262159AbTHYThK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 15:37:10 -0400
Date: Mon, 25 Aug 2003 12:32:12 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] limit some config options per arch.
Message-Id: <20030825123212.66ecac58.rddunlap@osdl.org>
In-Reply-To: <20030825185618.GA26255@ca-server1.us.oracle.com>
References: <20030825111854.5c4afdac.rddunlap@osdl.org.suse.lists.linux.kernel>
	<p73smnp4mbr.fsf@oldwotan.suse.de>
	<20030825113820.135217a7.rddunlap@osdl.org>
	<20030825185618.GA26255@ca-server1.us.oracle.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Aug 2003 11:56:19 -0700 Joel Becker <Joel.Becker@oracle.com> wrote:

| On Mon, Aug 25, 2003 at 11:38:20AM -0700, Randy.Dunlap wrote:
| > | >  config HANGCHECK_TIMER
| > | >  	tristate "Hangcheck timer"
| > | > +	depends on X86
| > | 
| > | AFAIK that's not x86 specific. It should work on other architecture too.
| > 
| > from willy@debian.org:
| > This looks x86-specific to me,
| > monotonic_clock() is in arch/i386 and arch/x86_64 only.
| 
| 	That's only becuase we haven't got implementations yet.  It's
| surely supposed to work on all platforms eventually.

OK, and then the Kconfig file can be updated, right?

--
~Randy
