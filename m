Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbUBTSw4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 13:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbUBTSw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 13:52:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:28055 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261251AbUBTSwy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 13:52:54 -0500
Date: Fri, 20 Feb 2004 10:45:21 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Thomas Munck Steenholdt <tmus@tmus.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pcnet32 link detection patch proposal
Message-Id: <20040220104521.4aaabd6e.rddunlap@osdl.org>
In-Reply-To: <40365368.5020508@tmus.dk>
References: <40365368.5020508@tmus.dk>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Feb 2004 19:35:20 +0100 Thomas Munck Steenholdt <tmus@tmus.dk> wrote:

| Hi Guys!
| 
| A lot of people have been experiencing problems with the pcnet32 nic 
| driver that
| always returns link down on some devices (including the VMware vlance 
| adapter).
| 
| The patch makes sure that link is always reported as up (in contrast to 
| always
| being rported as down) if the device is not MII capable. Devices that 
| ARE MII
| capable will return whatever mii_link_ok() says.
| 
| Please let be know what you think and possible give me a hint as to how 
| I can
| make sure this fix gets included whereever such a patch should be included!
| 
| Thanks a lot!

Hi,

There has been some recent pcnet32 driver activity on the netdev
mailing list.  Try that list.
Recent patches have been from Don Fry (brazilnut@us.ibm.com).
Mail archives for it are here:
  http://oss.sgi.com/projects/netdev/archive/
	

--
~Randy
