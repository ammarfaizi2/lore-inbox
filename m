Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265493AbUBAWw1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 17:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265516AbUBAWw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 17:52:27 -0500
Received: from smtp09.auna.com ([62.81.186.19]:47865 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S265493AbUBAWw0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 17:52:26 -0500
Date: Sun, 1 Feb 2004 23:52:24 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Greg KH <greg@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: hal daemon and ide-floppy
Message-ID: <20040201225224.GA4001@werewolf.able.es>
References: <20040126215036.GA6906@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040126215036.GA6906@kroah.com> (from greg@kroah.com on Mon, Jan 26, 2004 at 22:50:36 +0100)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

It looks like haldaemon is polling my zip to see inserted disks
(it is the only hadware I have that uses ide-floppy).
I get a message like this

Feb  1 23:50:15 werewolf kernel: ide-floppy: hdd: I/O error, pc =  0, key =  2, asc = 3a, ascq =  0
Feb  1 23:50:15 werewolf kernel: ide-floppy: hdd: I/O error, pc = 1b, key =  2, asc = 3a, ascq =  0
Feb  1 23:50:15 werewolf kernel: hdd: No disk in drive

every 2 seconds, both in messages and syslog.
They can grow very large after some uptime ;)

What is the policy here ? Kill the message in ide-floppy.c ?
I suppose there can be some other similat messages around there...

TIA

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Cooker) for i586
Linux 2.6.2-rc2-jam1 (gcc 3.3.2 (Mandrake Linux 10.0 3.3.2-4mdk))
