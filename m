Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbTEHXO1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 19:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbTEHXO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 19:14:27 -0400
Received: from air-2.osdl.org ([65.172.181.6]:51332 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262235AbTEHXO0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 19:14:26 -0400
Date: Thu, 8 May 2003 16:23:41 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jt@hpl.hp.com, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk,
       jgarzik@pobox.com
Subject: Re: The magical mystical changing ethernet interface order
Message-Id: <20030508162341.555a18bf.rddunlap@osdl.org>
In-Reply-To: <1052430385.13567.17.camel@dhcp22.swansea.linux.org.uk>
References: <20030508193245.GA26721@bougret.hpl.hp.com>
	<1052430385.13567.17.camel@dhcp22.swansea.linux.org.uk>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08 May 2003 22:46:26 +0100 Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

| On Iau, 2003-05-08 at 20:32, Jean Tourrilhes wrote:
| > 	My belief is that configuration scripts should be specified in
| > term of MAC address (or subset) and not in term of device name. Just
| > like the Pcmcia scripts are doing it.
| > 	And let's go the extra mile : ifconfig should accept a MAC
| > address as the argument instead of a device name. And in the long
| > term, just get rid of device name from the user view.
| 
| Current Red Hat supports naming interfaces by their mac address. That
| keeps most people happy except some sparc and embedded users who have
| one mac per host not per card (and yes that *is* allowed by the
| 802.x spec)

Yep, found it in IEEE Std 802-2001.  It's just not the recommended
method for device address assignment.

--
~Randy
