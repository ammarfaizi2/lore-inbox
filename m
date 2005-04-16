Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261978AbVDPKw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbVDPKw7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 06:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbVDPKw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 06:52:59 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:8106 "EHLO slimnas.slim")
	by vger.kernel.org with ESMTP id S261978AbVDPKw6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 06:52:58 -0400
Subject: Re: SCSI opcode 0x80 and 3ware Escalade 7000 ATA RAID
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: linux-kernel@vger.kernel.org
Cc: aradford@gmail.com, mrmacman_g4@mac.com
In-Reply-To: <8c5d8e66ebfcfe879244a18068544dc3@mac.com>
References: <8c5d8e66ebfcfe879244a18068544dc3@mac.com>
Content-Type: text/plain
Date: Sat, 16 Apr 2005 12:52:51 +0200
Message-Id: <1113648771.5928.10.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-15 at 18:26 -0400, Kyle Moffett wrote:
> I've been getting the following message in syslog on a couple of my 
> servers
> recently:
> 
> > Apr 15 16:41:18 king kernel: scsi: unknown opcode 0x80

I now am seeing the same error messages on my 3ware 9000 controller
running kernel 2.6.11 (actually 2.6.11-1.14-FC3smp from FC3):

scsi: unknown opcode 0x80
3w-9xxx: scsi0: ERROR: (0x03:0x0101): Invalid command
opcode:opcode=0x80.

My smartd is configured to use the proper 3ware devices:

/dev/twa0 -d 3ware,0 -H -m root@localhost.localdomain
/dev/twa0 -d 3ware,1 -H -m root@localhost.localdomain
/dev/twa0 -d 3ware,2 -H -m root@localhost.localdomain
/dev/twa0 -d 3ware,3 -H -m root@localhost.localdomain

Jurgen


