Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263173AbTC1WUn>; Fri, 28 Mar 2003 17:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263175AbTC1WUn>; Fri, 28 Mar 2003 17:20:43 -0500
Received: from air-2.osdl.org ([65.172.181.6]:51884 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S263173AbTC1WUm>;
	Fri, 28 Mar 2003 17:20:42 -0500
Date: Fri, 28 Mar 2003 14:27:28 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: davej@codemonkey.org.uk, linux-kernel@vger.kernel.org
Subject: Re: NICs trading places ?
Message-Id: <20030328142728.4f242f80.rddunlap@osdl.org>
In-Reply-To: <20030328222524.GK32000@ca-server1.us.oracle.com>
References: <20030328221037.GB25846@suse.de>
	<20030328222524.GK32000@ca-server1.us.oracle.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Mar 2003 14:25:25 -0800 Joel Becker <Joel.Becker@oracle.com> wrote:

| On Fri, Mar 28, 2003 at 10:10:37PM +0000, Dave Jones wrote:
| > I just upgraded a box with 2 NICs in it to 2.5.66, and found
| > that what was eth0 in 2.4 is now eth1, and vice versa.
| > Is this phenomenon intentional ? documented ?
| > What caused it to do this ?
| 
| 	Is this a Red Hat system?  I encountered the same thing on a
| RHAS system.  Basically, Anaconda had controlled the module load order
| in /etc/modules.conf for 2.4.  Because my network drivers were built in
| in 2.5, they loaded in the order of the compile-in.  This turned out to
| be the reverse order.
| 	Swapping eth0 and eth1 in /etc/modules.conf fixed the problem
| for me.  This is not to say it is "Red Hat's fault" or that this is
| entirely the same situation, but I figured this would make a good
| datapoint.

I saw this same problem at home last night, not on a RH system,
so I think it's just a 2.5.lately thing.

--
~Randy
