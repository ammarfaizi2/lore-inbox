Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262645AbTFDC6W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 22:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbTFDC6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 22:58:22 -0400
Received: from pizda.ninka.net ([216.101.162.242]:10196 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262633AbTFDC6U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 22:58:20 -0400
Date: Tue, 03 Jun 2003 20:09:44 -0700 (PDT)
Message-Id: <20030603.200944.78736971.davem@redhat.com>
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       linux-net@vger.kernel.org
Subject: Re: Regarding SET_NETDEV_DEV
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030603175921.GE2079@gtf.org>
References: <20030603175921.GE2079@gtf.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jeff Garzik <jgarzik@pobox.com>
   Date: Tue, 3 Jun 2003 13:59:21 -0400

   For janitors and other developers placing this in net drivers...
   please don't :)  This can be done in upper layers, accomplishing the
   same goal without changing the low-level net driver code at all.
   
Don't say something can be done without showing exactly
how :-)

How does register_netdevice() know that the device is "whatever" and
where to get the generic device struct from?

