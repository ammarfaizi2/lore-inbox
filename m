Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265825AbUBBU2u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 15:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265847AbUBBU0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 15:26:47 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:27780 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S265826AbUBBU0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 15:26:30 -0500
Date: Mon, 2 Feb 2004 20:25:22 +0000
From: Dave Jones <davej@redhat.com>
To: DervishD <raul@pleyades.net>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with IDE taskfile
Message-ID: <20040202202522.GA9503@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	DervishD <raul@pleyades.net>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <20040202120120.GC570@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202120120.GC570@DervishD>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 02, 2004 at 01:01:20PM +0100, DervishD wrote:

 > <28>Feb  2 12:18:41 kernel: hdb: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
 > <28>Feb  2 12:18:41 kernel: hdb: task_no_data_intr: error=0x04 { DriveStatusError }
 > <30>Feb  2 12:18:41 kernel: hdb: 8420832 sectors (4311 MB) w/512KiB Cache, CHS=524/255/63, UDMA(33)
 > 
 >     The problem is that message from function 'task_no_data_intr'.
 > What can be the problem? Should I worry about it? Is the drive
 > damaged?

51/04 is the drive saying "I don't understand what you asked me to do".
Ie, a command that was added to a later revision of the ATA standard
than your drive conforms to.  Judging by the size of the drive,
I'd guess it's quite old 8-)

		Dave

