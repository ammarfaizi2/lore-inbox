Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264296AbTKUDb3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 22:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbTKUDb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 22:31:29 -0500
Received: from pix-525-pool.redhat.com ([66.187.233.200]:7904 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264296AbTKUDb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 22:31:28 -0500
Date: Thu, 20 Nov 2003 22:28:19 -0500
From: Bill Nottingham <notting@redhat.com>
To: jt@hpl.hp.com
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [PATCH] All my Pcmcia cards are 'eth0'
Message-ID: <20031121032819.GA2120@devserv.devel.redhat.com>
Mail-Followup-To: jt@hpl.hp.com,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	linux-hotplug-devel@lists.sourceforge.net
References: <20031121031359.GA19405@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031121031359.GA19405@bougret.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes (jt@bougret.hpl.hp.com) said: 
> 	One of the main problem is that they are all assigned 'eth0',
> and therefore all configured with the same IP address. This is really
> pathetic.
> 
> 	The usual answer is : you should use 'nameif' :
> http://www.xenotime.net/linux/doc/network-interface-names.txt
> 	Well, of course, nobody ever bothered to try it, so it doesn't
> work. No comments.

Well, no offense, but I'd think comments are necessary about no
one bothering to try it and it not working. I've had an orinoco_cs
device 'bob' using nameif for a while.

There are some situations where you have to jump through hoops
because it can't atomically swap two device names (i.e.,
eth0 <-> eth1, but the code itself seems to work ok in use here...

Bill
