Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268736AbTBZMx5>; Wed, 26 Feb 2003 07:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268738AbTBZMx5>; Wed, 26 Feb 2003 07:53:57 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:45449
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268736AbTBZMx4>; Wed, 26 Feb 2003 07:53:56 -0500
Subject: Re: DTE 3181e
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pablo B <pablob127@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030226054404.85557.qmail@web40102.mail.yahoo.com>
References: <20030226054404.85557.qmail@web40102.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046268367.8948.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 26 Feb 2003 14:06:07 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-26 at 05:44, Pablo B wrote:
> I am trying to use an ancient DTC 3181e SCSI card with
> the 2.4.20 kernel. However, whenever I load the
> g_NCR5380 module with a SCSI device on, it inmediately
> freezes the computer hard. The system gets completely
> hung, needs a hard reset to restart (no Alt-SysRq
> magic keys available).
> I've been looking for information on the Net, but I
> could not find anybody with similar problems.

The driver is a bit cranky to say the least. It gets deeply
upset if the bus locks for example. I did a lot of work on it
in 2.5 and the 2.5 one seems to be stable and a lot better
on my test box with a similar card (53c400a with no IRQ)

