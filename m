Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310337AbSCGODC>; Thu, 7 Mar 2002 09:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310335AbSCGOCt>; Thu, 7 Mar 2002 09:02:49 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:34830 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310337AbSCGOCX>; Thu, 7 Mar 2002 09:02:23 -0500
Subject: Re: [PATCH] Rework of /proc/stat
To: jean-eric.cuendet@linkvest.com (Jean-Eric Cuendet)
Date: Thu, 7 Mar 2002 14:17:45 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C8770D5.3040108@linkvest.com> from "Jean-Eric Cuendet" at Mar 07, 2002 02:53:25 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16iyiH-0002Oo-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The only drawback is:
> - infos are in /proc/partitions not in /proc/stat (some apps get infos 
> there...)
> Right?

Yes - proc/stat doesn't have the fields to provide enough (and per
partition) info.

> PS: When will it be in official tree? An idea?

I hope to feed it to Marcelo for 2.4.19
