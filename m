Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311719AbSCNShh>; Thu, 14 Mar 2002 13:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311720AbSCNSh1>; Thu, 14 Mar 2002 13:37:27 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:14097 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311719AbSCNShW>; Thu, 14 Mar 2002 13:37:22 -0500
Subject: Re: HPT370 RAID-1 or Software RAID-1, what's "best"?
To: thunder@ngforever.de (Thunder from the hill)
Date: Thu, 14 Mar 2002 18:53:11 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, nitrax@giron.wox.org (Martin Eriksson)
In-Reply-To: <3C90ECDF.8EBC8FD4@ngforever.de> from "Thunder from the hill" at Mar 14, 2002 11:33:03 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16laLf-0001br-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Software RAID is just your disk configuration. But I'd recommend
> hardware raid because the rebuild after one disk crash is dog slow with
> software raid. This problem been discussed in all possible linux
> magazines...

The raid rebuild time is identical for pretty much any set up. With the
softraid its intentionally defaulting to a low fraction of I/O bandwidth
so it doesnt disrupt normal operation.

Also as far is his question goes - both are software raid
