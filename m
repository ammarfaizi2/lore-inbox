Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbTDQQn6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 12:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbTDQQn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 12:43:58 -0400
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:51147 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261700AbTDQQn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 12:43:56 -0400
Date: Thu, 17 Apr 2003 18:55:40 +0200
From: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
To: linux-kernel@vger.kernel.org, linux-admin@vger.kernel.org,
       users@lists.freeswan.org, sfs-users@freeswan.ca
Subject: ARP
Message-Id: <20030417185540.28c74d42.Christoph.Pleger@uni-dortmund.de>
Organization: Universitaet Dortmund
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; sparc-sun-solaris2.6)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I want to use FreeS/WAN with kernel 2.4. For the configuration I have to
reach with FreeS/WAN I need the ability to tell a host that it shall
accept traffic which is directed to another host. I tried doing that by
the user space program arp, but it did not work and after that I read in
the manual page of arp that since kernel version 2.2.0 setting an arp
entry for a whole subnet is no longer supported. 

Is there something else I can do to tell the hosts in a subnet to send
packets for a specific not to that host itself but to another host? This
should be done transparently so that the hosts do not know that their ip
packets do not go directly to the destination.

Kind regards
  Christoph
