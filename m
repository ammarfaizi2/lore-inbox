Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269039AbTBZWqH>; Wed, 26 Feb 2003 17:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269127AbTBZWqG>; Wed, 26 Feb 2003 17:46:06 -0500
Received: from air-2.osdl.org ([65.172.181.6]:10963 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S269039AbTBZWqF>;
	Wed, 26 Feb 2003 17:46:05 -0500
Date: Wed, 26 Feb 2003 14:51:54 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Mark Haverkamp <markh@osdl.org>
Cc: mbligh@aracnet.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: 2.5.62-mjb3 (scalability / NUMA patchset)
Message-Id: <20030226145154.380e9210.rddunlap@osdl.org>
In-Reply-To: <1046299742.3375.3.camel@markh1.pdx.osdl.net>
References: <6490000.1045713212@[10.10.2.4]>
	<16170000.1046110132@[10.10.2.4]>
	<1046273777.1913.6.camel@markh1.pdx.osdl.net>
	<3090000.1046274931@[10.10.2.4]>
	<1046299742.3375.3.camel@markh1.pdx.osdl.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

| 
| I turned on NMI watchdogs and when the system hung, I saw no output.  My
| serial console is through a terminal server that isn't set up to pass
| along the sysrq, so I need to get this fixed.  In any case I backed out
| the patch that you suggested and I have had no system hangs since.
| 
| Mark.
| -- 
| Mark Haverkamp <markh@osdl.org>

Mark,

You can also use my "echo key > sysrq" patch.
It was updated to 2.5.62 by Zwane M.
It's available at www.osdl.org/archive/rddunlap/patches/magickey_2562.patch
(after a possible 15-minute rsync delay).

--
~Randy
