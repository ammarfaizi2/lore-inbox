Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263203AbTIVQZa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 12:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263206AbTIVQZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 12:25:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:14294 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263203AbTIVQZ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 12:25:28 -0400
Date: Mon, 22 Sep 2003 09:18:00 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Kirk Reiser <kirk@braille.uwo.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: unknown symbols loading modules under 2.6.x
Message-Id: <20030922091800.3b2532ec.rddunlap@osdl.org>
In-Reply-To: <E1A1TE1-00075s-00@speech.braille.uwo.ca>
References: <E1A1TE1-00075s-00@speech.braille.uwo.ca>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Sep 2003 12:07:45 -0400 Kirk Reiser <kirk@braille.uwo.ca> wrote:

| Hello Everyone:  I have been trying to hunt down the answer to
| aproblem I am having attempting to load my modules under the 2.6.x
| kernels.  They load just fine under the 2.4.x kernels.  Have there
| been changes which need to be made to get symbols found with modprobe
| other than the EXPORT_SYMBOL() macro?  The symbols show up in the
| modules.symbols file created by depmod.  They appear to reference the
| correct loadable module.  The loadable module these symbols are
| exported in however is comprised of two separate .o files during
| compile.  I am not sure whether that has anything to do with it or
| not.
| 
| If someone could give me an idea what to read to solve this I'd
| appreciate it.

Make sure that you have the current version of module-init-tools
installed from http://www.kernel.org/pub/linux/kernel/people/rusty/modules/
and that scripts are using them (ie, check PATH).

If it's still not working, please post more complete info about the
problem.

--
~Randy
