Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284905AbSABV6e>; Wed, 2 Jan 2002 16:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284886AbSABV6O>; Wed, 2 Jan 2002 16:58:14 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:13582 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284860AbSABV6H>; Wed, 2 Jan 2002 16:58:07 -0500
Subject: Re: ISA slot detection on PCI systems?
To: esr@thyrsus.com
Date: Wed, 2 Jan 2002 22:08:56 +0000 (GMT)
Cc: davej@suse.de (Dave Jones), alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <20020102163043.A16513@thyrsus.com> from "Eric S. Raymond" at Jan 02, 2002 04:30:43 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16LtZA-0005hV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Consider the lives of people administering large server farms or clusters.
> Their hardware is not necessarily homogenous, and the ability to query the DMI
> tables on the fly could be useful both for administration and automatic
> process migration.

I considered it. If you take the base DMI table scanner you can trivially
write a setuid app that simply outputs the DMI table block to fd 1. You
can validate that app is secure, takes no arguments etc.

On that basis it doesnt need the kernel involved
