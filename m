Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271004AbTGPR2B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 13:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270996AbTGPRXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 13:23:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:60618 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270966AbTGPRWc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 13:22:32 -0400
Date: Wed, 16 Jul 2003 10:35:17 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Pedro Ribeiro <deadheart@netcabo.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with 2.6.0-test1 && depmod
Message-Id: <20030716103517.65e146bc.rddunlap@osdl.org>
In-Reply-To: <3F15E439.70107@netcabo.pt>
References: <3F15E439.70107@netcabo.pt>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jul 2003 00:48:09 +0100 Pedro Ribeiro <deadheart@netcabo.pt> wrote:

| I've just installed 2.6.0-test1 but whenever I try to use depmod, lsmod 
| or insmod I get this error:
| 
| Module                  Size  Used by    Not tainted
| lsmod: QM_MODULES: Function not implemented
| 
| I first noticed this when I was trying to install the nvidia drivers. 
| Needless to say that I was unable to install them. What can I do to 
| solve this problem? By the way,
| 
| depmod version 2.4.16

Please read
  http://www.codemonkey.org.uk/post-halloween-2.5.txt
when it's back online (maybe 2 hours).

Also, you need to use the module-init-tools for 2.6.
They are at
  http://www.kernel.org/pub/linux/kernel/people/rusty/modules/

--
~Randy
| http://developer.osdl.org/rddunlap/ | http://www.xenotime.net/linux/ |
For Linux-2.6:
http://www.codemonkey.org.uk/post-halloween-2.5.txt
http://www.kernel.org/pub/linux/kernel/people/rusty/modules/
