Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263094AbTIKAUl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 20:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266115AbTIKAUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 20:20:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:54458 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263094AbTIKAUg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 20:20:36 -0400
Date: Wed, 10 Sep 2003 17:14:40 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Matias Alejo Garcia <kernel@matiu.com.ar>
Cc: linux-kernel@vger.kernel.org
Subject: Re: test5-bk1: Compilation Error in net/atm/br2684.c
Message-Id: <20030910171440.15c20961.rddunlap@osdl.org>
In-Reply-To: <1063236505.4636.2.camel@runner>
References: <1063236505.4636.2.camel@runner>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Sep 2003 19:28:26 -0400 Matias Alejo Garcia <kernel@matiu.com.ar> wrote:

| 
| Compiling 2.6.0test5-bk1, I got the following:
| 
| -------------
| net/atm/br2684.c: In function `br2684_seq_show':
| net/atm/br2684.c:735: `pos' undeclared (first use in this function)
| net/atm/br2684.c:735: (Each undeclared identifier is reported only once
| net/atm/br2684.c:735: for each function it appears in.)
| net/atm/br2684.c:736: `buf' undeclared (first use in this function)
| make[2]: *** [net/atm/br2684.o] Error 1
| make[1]: *** [net/atm] Error 2

Yes, bug and patch have been posted several times...

Maybe in netdev archives instead of lkml.
See http://oss.sgi.com/projects/netdev/archive/

--
~Randy
