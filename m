Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268594AbUHLPis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268594AbUHLPis (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 11:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268595AbUHLPis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 11:38:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:63699 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268594AbUHLPiq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 11:38:46 -0400
Date: Thu, 12 Aug 2004 08:16:34 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Len Brown <len.brown@intel.com>
Cc: pavel@suse.cz, trenn@suse.de, seife@suse.de, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: Allow userspace do something special on overtemp
Message-Id: <20040812081634.532e3fc7.rddunlap@osdl.org>
In-Reply-To: <1092323945.5028.177.camel@dhcppc4>
References: <20040811085326.GA11765@elf.ucw.cz>
	<1092323945.5028.177.camel@dhcppc4>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Aug 2004 11:19:05 -0400 Len Brown wrote:

| Simpler to delete the usermode call and rely on the (flexible)
| acpid event, yes?
| 
|  thermal.c |   29 +----------------------------
|  1 files changed, 1 insertion(+), 28 deletions(-)

a.  Yes, it should be more flexible than just 'overtemp'.

b.  For userspace, there are:

acpid -  http://sourceforge.net/projects/acpid/

acpi tools, like ospmd (by Andy Grover) - in CVS at
  http://sourceforge.net/projects/acpi/

What others are there?

And ospmd (at least) needs some care.  Andy wanted to give it up
1 or 2 years ago, so I took it over for awhile.  However, it
still needs more care, so if anyone out there wants to maintain it,
please speak up.

--
~Randy
