Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263217AbTCNCGj>; Thu, 13 Mar 2003 21:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263219AbTCNCGj>; Thu, 13 Mar 2003 21:06:39 -0500
Received: from [216.234.192.169] ([216.234.192.169]:57098 "HELO
	miranda.zianet.com") by vger.kernel.org with SMTP
	id <S263217AbTCNCGi>; Thu, 13 Mar 2003 21:06:38 -0500
Subject: Re: for the spelling checkers
From: Steven Cole <elenstev@mesatop.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030313113602.7bd3c6f0.rddunlap@osdl.org>
References: <20030313113602.7bd3c6f0.rddunlap@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 13 Mar 2003 19:14:43 -0700
Message-Id: <1047608096.14782.5299.camel@spc1.mesatop.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-13 at 12:36, Randy.Dunlap wrote:
> 
> for the spelling checkers/fixers:
[snipped] 

Thanks Randy,  I'll make sure those get put in our
corrections list.  We're slowly feeding patches to the maintainers.

> 
> * net/ipv4/route.c::1856:
> . change "wrong by three" to "wrong for two"

That odd comment entered the tree with 2.1.68, and has been unchanged
since then.  Ever hesitant to accidentally remove a snippet of humor,
I would vote to leave this as is.

		/* I removed check for oif == dev_out->oif here.
		   It was wrong by three reasons:
		   1. ip_dev_find(saddr) can return wrong iface, if saddr is
		      assigned to multiple interfaces.
		   2. Moreover, we are allowed to send packets with saddr
		      of another iface. --ANK
		 */

Thanks for finding the other stuff.

Steven



