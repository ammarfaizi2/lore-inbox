Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263008AbTJ0QnJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 11:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263179AbTJ0QnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 11:43:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:8401 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263008AbTJ0QnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 11:43:06 -0500
Date: Mon, 27 Oct 2003 08:40:43 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Emmanuel Fleury <fleury@cs.auc.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Remote Serial Console on 2.6.x ?
Message-Id: <20031027084043.4847224c.rddunlap@osdl.org>
In-Reply-To: <1067248709.30367.10.camel@rade7.s.cs.auc.dk>
References: <1067248709.30367.10.camel@rade7.s.cs.auc.dk>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Oct 2003 10:58:29 +0100 Emmanuel Fleury <fleury@cs.auc.dk> wrote:

| Hi,
| 
| I was used to debug my kernel code with the remote serial console
| facility on the 2.4.x serie, but I really can't figure how does it works
| to activate it on the 2.6.0-test9 that I just got.
| 
| I took a look at the relevant HOWTO:
| http://www.tldp.org/HOWTO/Remote-Serial-Console-HOWTO/kernelcompile-25.html
| 
| But, it seems that all the configure scheme has changed for the 2.6.x...
| 
| Can anybody give me some pointers on a documentation or give me some
| hints ???

Hi,

Here's how it looks in 2.6.0-test9:


Device Drivers:
  Character devices:
    Serial drivers:
      <*> 8250/16550 and compatible serial support
          (CONFIG_SERIAL_8250=y)
      [*]   Console on 8250/16550 and compatible serial port
            (CONFIG_SERIAL_8250_CONSOLE=y)


HTH.
--
~Randy
