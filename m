Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264579AbUENXZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264579AbUENXZO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 19:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264561AbUENXWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:22:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:59835 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264579AbUENXTH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:19:07 -0400
Date: Fri, 14 May 2004 16:19:04 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wright <chrisw@osdl.org>, joern@wohnheim.fh-wedel.de,
       arjanv@redhat.com, benh@kernel.crashing.org, kronos@kronoz.cjb.net,
       linux-kernel@vger.kernel.org
Subject: Re: [4KSTACK][2.6.6] Stack overflow in radeonfb
Message-ID: <20040514161904.C21045@build.pdx.osdl.net>
References: <20040513145640.GA3430@dreamland.darkstar.lan> <1084488901.3021.116.camel@gaston> <20040513182153.1feb488b.akpm@osdl.org> <20040514094923.GB29106@devserv.devel.redhat.com> <20040514114746.GB23863@wohnheim.fh-wedel.de> <20040514151520.65b31f62.akpm@osdl.org> <20040514155643.G22989@build.pdx.osdl.net> <20040514161814.3e1f690e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040514161814.3e1f690e.akpm@osdl.org>; from akpm@osdl.org on Fri, May 14, 2004 at 04:18:14PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> Well find .  -name '*.o' -a -not -name '*.mod.o' would fix that up but the
> dupes are coming from the intermediate .o files which the build system
> prepares.  sound/core/snd.o contains sound/core/snd-pcm.o contains
> sound/core/pcm_native.o.

i wonder if limiting to vmlinux and .ko's would be clean?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
