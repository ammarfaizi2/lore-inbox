Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310270AbSCAA56>; Thu, 28 Feb 2002 19:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310261AbSCAA4H>; Thu, 28 Feb 2002 19:56:07 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:44560 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310272AbSCAAwx>; Thu, 28 Feb 2002 19:52:53 -0500
Subject: Re: 2.4.19-preX: What we really need: -AA patches finally in the
To: riel@conectiva.com.br (Rik van Riel)
Date: Fri, 1 Mar 2002 01:04:26 +0000 (GMT)
Cc: davidsen@tmr.com (Bill Davidsen), hch@caldera.de (Christoph Hellwig),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.33L.0202282002260.2801-100000@imladris.surriel.com> from "Rik van Riel" at Feb 28, 2002 08:04:38 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16gbTG-0001rM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> or (c) have proponents of the inclusion of the O(1) scheduler
> fix all drivers before having the O(1) scheduler considered
> for inclusion.

According to find and grep the patch in general use does precisely that
except for Andrea's yield loops on init kill funnies that still lurk in
the non x86 parts of rmap. If rmap doesnt need them I guess they should go ?

