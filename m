Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263697AbTI2Qhx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 12:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263696AbTI2Qhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 12:37:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:31972 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263697AbTI2Qhw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 12:37:52 -0400
Date: Mon, 29 Sep 2003 09:29:52 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Smurf <smurf@play.smurf.noris.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] No forced rebuilding of ikconfig.h
Message-Id: <20030929092952.7ba7b1c0.rddunlap@osdl.org>
In-Reply-To: <20030929153815.GA16685@play.smurf.noris.de>
References: <20030929153815.GA16685@play.smurf.noris.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Sep 2003 17:38:15 +0200 Smurf <smurf@play.smurf.noris.de> wrote:

| Why does ikconfig.h require forced rebuilding?
| I can't think of a reason...

Would you describe the problem, if any?

Since I removed linux/compile.h and linux/version.h from
kernel/configs.c (as in -test6), I don't see any rebuilding
happening.  When does it happen?

Also, what kernel version are you referring to???

--
~Randy
