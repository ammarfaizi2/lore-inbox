Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264176AbTH1Pvs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 11:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264179AbTH1Pvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 11:51:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:57061 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264176AbTH1Pvp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 11:51:45 -0400
Date: Thu, 28 Aug 2003 08:46:40 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Tomasz Czaus <tomasz_czaus@go2.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4 and hardware reports a non fatal incident
Message-Id: <20030828084640.68fe827d.rddunlap@osdl.org>
In-Reply-To: <200308281548.44803.tomasz_czaus@go2.pl>
References: <200308281548.44803.tomasz_czaus@go2.pl>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Aug 2003 15:48:44 +0200 Tomasz Czaus <tomasz_czaus@go2.pl> wrote:

| Hello,
| 
| when my system is booting I can see such a message:
| 
| kernel: MCE: The hardware reports a non fatal, correctable incident occurred 
| on CPU 0.
| kernel: Bank 0: e664000000000185
| 
| What does it mean ??? My kernel 2.6.0-test4 has applyed "Nick's scheduler 
| policy v8" patch. 

Use "parsemce" from here:
  http://www.codemonkey.org.uk/projects/parsemce/
to decode it.

| When I boot 2.4.x kernel I can't see this message.

So 2.6 has more/better/different processor error checking.

--
~Randy
