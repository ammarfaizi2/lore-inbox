Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbTFGJgX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 05:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262903AbTFGJgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 05:36:23 -0400
Received: from pizda.ninka.net ([216.101.162.242]:45444 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262884AbTFGJgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 05:36:22 -0400
Date: Sat, 07 Jun 2003 02:47:04 -0700 (PDT)
Message-Id: <20030607.024704.13764413.davem@redhat.com>
To: rmk@arm.linux.org.uk
Cc: davidm@hpl.hp.com, manfred@colorfullife.com, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: problem with blk_queue_bounce_limit()
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030607104434.B22665@flint.arm.linux.org.uk>
References: <20030606.234401.104035537.davem@redhat.com>
	<16097.37454.827982.278024@napali.hpl.hp.com>
	<20030607104434.B22665@flint.arm.linux.org.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Russell King <rmk@arm.linux.org.uk>
   Date: Sat, 7 Jun 2003 10:44:34 +0100
   
   It is rather unfortunate that this got called "PCI_xxx" since it has
   been used in a non pci-bus manner in (eg) the scsi layer.

I agree, the idea at the time that Jens and myself did this
work was that the generic device layer would provide interfaces
by which we could test this given a struct device.
