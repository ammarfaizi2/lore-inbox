Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310316AbSCGNff>; Thu, 7 Mar 2002 08:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310323AbSCGNfZ>; Thu, 7 Mar 2002 08:35:25 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18190 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310316AbSCGNfV>; Thu, 7 Mar 2002 08:35:21 -0500
Subject: Re: [PATCH] Rework of /proc/stat
To: cmm@us.ibm.com (mingming cao)
Date: Thu, 7 Mar 2002 13:50:34 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        jean-eric.cuendet@linkvest.com (Jean-Eric Cuendet),
        linux-kernel@vger.kernel.org
In-Reply-To: <3C86BEB0.4090203@us.ibm.com> from "mingming cao" at Mar 06, 2002 05:13:20 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16iyHy-0002Ij-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Any reason for preferring this over the sard patches in -ac ?
> 
> Basically, statistic data are moved from the global kstat structure to 
> the request_queue structures, and it is allocated/freed when the request 
> queue is initialized and freed.  This way it is

So does sard
