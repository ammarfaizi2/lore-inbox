Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264790AbUEKPn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264790AbUEKPn6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 11:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264798AbUEKPn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 11:43:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:943 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264790AbUEKPn4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 11:43:56 -0400
Date: Tue, 11 May 2004 08:35:04 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Andi Kleen <ak@muc.de>
Cc: rusty@rustcorp.com.au, akpm@osdl.org, ak@muc.de, sam@ravnborg.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Sort kallsyms in name order: kernel shrinks by 30k
Message-Id: <20040511083504.16686244.rddunlap@osdl.org>
In-Reply-To: <20040511080843.GB8751@colin2.muc.de>
References: <1084252135.31802.312.camel@bach>
	<20040511080843.GB8751@colin2.muc.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 May 2004 10:08:43 +0200 Andi Kleen wrote:

| On Tue, May 11, 2004 at 03:08:55PM +1000, Rusty Russell wrote:
| > Admittedly, anyone who sets CONFIG_KALLSYMS doesn't care about space,
| > it's a fairly trivial change.
| 
| As long as nobody does binary search it's good. Wonder why I did not
| have this idea already with the original stem compression change ;-)

My (limited) experience is that things reading /proc/kallsyms want
to see it in sorted address order, not in sorted name order.

--
~Randy
(Again.  Sometimes I think ln -s /usr/src/linux/.config .signature) -- akpm
