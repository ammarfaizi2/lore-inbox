Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270911AbTGPPFK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 11:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270913AbTGPPFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 11:05:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:48854 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270911AbTGPPFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 11:05:05 -0400
Date: Wed, 16 Jul 2003 08:16:39 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: root@mauve.demon.co.uk
Cc: stephane.wirtel@belgacom.net, linux-kernel@vger.kernel.org
Subject: Re: How to test the new kernel 2.6.0-test1 ?
Message-Id: <20030716081639.4f40b6b0.rddunlap@osdl.org>
In-Reply-To: <200307161025.LAA01549@mauve.demon.co.uk>
References: <20030716082731.GA6202@stargate.brutele.be>
	<200307161025.LAA01549@mauve.demon.co.uk>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jul 2003 11:25:18 +0100 (BST) root@mauve.demon.co.uk wrote:

| > I am using the kernel 2.6.0-test1 on my computer, and it works perfectly.
| > 
| > Which are the weaknesses of the new kernel, an idea ?
| 
| It almost certainly has bugs.
| Most of the ones present probably don't show up much on an average 
| machine, with an average load.
| 
| Try the edge cases, such as plugging in twenty thousand USB mice, running
| it on a 386/20 with 4Mb ram, unplugging USB devices when in use, ...
| 
| The rarer bugs that do present on an average machine, with average loading
| just need more people to test, and report oopses or other errors related
| to the kernel.
| 
| Just running it helps, if only because it lowers the probability of such
| bugs being present before 2.6.0 is released.

The I/O schedulers and process(or) scheduler want to be beaten on
very badly.  For process scheduler, try playing music and writing
a CD while building kernels etc. and see how well you can move the
mouse around in X.

--
~Randy
| http://developer.osdl.org/rddunlap/ | http://www.xenotime.net/linux/ |
