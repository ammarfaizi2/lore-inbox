Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263279AbSKFC7b>; Tue, 5 Nov 2002 21:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264779AbSKFC7b>; Tue, 5 Nov 2002 21:59:31 -0500
Received: from jdike.solana.com ([198.99.130.100]:37249 "EHLO karaya.com")
	by vger.kernel.org with ESMTP id <S263279AbSKFC7b>;
	Tue, 5 Nov 2002 21:59:31 -0500
Message-Id: <200211060308.gA638Ui08714@karaya.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-rc1 - hang with processes stuck in D 
In-Reply-To: Your message of "Tue, 05 Nov 2002 16:37:47 PST."
             <3DC8645B.A0E99A99@digeo.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 05 Nov 2002 22:08:30 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

akpm@digeo.com said:
> Kernel is waiting for IO completion on a read.  I would be suspecting
> your IO system, or interrupt system. 

Yup.  The disk access light is stuck on continuously at this point, FWIW.


> Reverting your ide/scsi/whatever drivers to the last-known-to-work
> version would be interesting. 

IDE - this didn't happen on 2.4.18.  It seems to happen on all more recent
kernels.  UML seems to trigger it, especially on UML servers.

				Jeff

