Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267256AbTAUWZJ>; Tue, 21 Jan 2003 17:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267257AbTAUWZJ>; Tue, 21 Jan 2003 17:25:09 -0500
Received: from dhcp34.trinity.linux.conf.au ([130.95.169.34]:4480 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id <S267256AbTAUWZI>; Tue, 21 Jan 2003 17:25:08 -0500
Subject: Re: 32bit dev_t
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Steven Dake <sdake@mvista.com>
Cc: Joel Becker <Joel.Becker@oracle.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E2DBBAD.80206@mvista.com>
References: <20030121195041.GE20972@ca-server1.us.oracle.com>
	 <3E2DBBAD.80206@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043188385.1384.1.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 21 Jan 2003 22:33:05 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-21 at 21:29, Steven Dake wrote:
> Joel,
> 
> Linux doesn't really need a 32 bit kdev_t structure to support 1000 
> disks.  There is plenty of device space available to support over 1500 
> disks by modifying the linux scsi layer.

You run out of assigned major/minor numbers. There is a sick hack that
steals other device idents but thats not usable in a production environment.
32bit dev_t IMHO is essential to 2.6. Essential enough that if its not in
the base 2.6 all the vendors have to get together and issue a Linus 
incompatible but common 32bit dev_t interface.


