Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264412AbUFRWtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264412AbUFRWtR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 18:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264482AbUFRWtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 18:49:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:63390 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264412AbUFRWpp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 18:45:45 -0400
Date: Fri, 18 Jun 2004 15:43:02 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: sam@ravnborg.org, willy@w.ods.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] save kernel version in .config file
Message-Id: <20040618154302.01fc46c2.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0406190036440.10292@scrub.local>
References: <20040617220651.0ceafa91.rddunlap@osdl.org>
	<20040618053455.GF29808@alpha.home.local>
	<20040618205602.GC4441@mars.ravnborg.org>
	<20040618150535.6a421bdb.rddunlap@osdl.org>
	<Pine.LNX.4.58.0406190036440.10292@scrub.local>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jun 2004 00:42:19 +0200 (CEST) Roman Zippel wrote:

| Hi,
| 
| On Fri, 18 Jun 2004, Randy.Dunlap wrote:
| 
| Did you test this with anything else than menuconfig?

Nope...

| > +		     (char *)sym->curr.val, ctime(&now));
| 
| Try to avoid poking around in that structure. First the value needs to be 
| calculated with sym_calc_value() and then it can be accessed with 
| sym_get_string_value().

Thanks, will use that info.

--
~Randy
