Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270859AbTHSQBu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 12:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270858AbTHSQBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 12:01:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:32429 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270859AbTHSQAy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 12:00:54 -0400
Date: Tue, 19 Aug 2003 08:56:52 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Install new kernel without reboots.
Message-Id: <20030819085652.3b157f56.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.51.0308191729290.27171@dns.toxicfilms.tv>
References: <Pine.LNX.4.51.0308191729290.27171@dns.toxicfilms.tv>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003 17:30:52 +0200 (CEST) Maciej Soltysiak <solt@dns.toxicfilms.tv> wrote:

| Hi,
| 
| I have heard it is possible to change the kernel without reboots.
| And I am not talking about UML.
| 
| Is it true? I could not find any documents on the web.

Eric Biederman has been working on 'kexec', which is a fast
reboot (Linux boots Linux).  See
  http://www.xmission.com/~ebiederm/files/kexec/
and
  http://developer.osdl.org/%7Eandyp/kexec/
for some 2.5.[67]x versions.  I'm trying to update it to
2.6.0-test3 and make it reboot successfully on my dual P4
machine.  Currently it hangs during the reboot.

--
~Randy
"Everything is relative."
