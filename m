Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315255AbSEVOcH>; Wed, 22 May 2002 10:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315178AbSEVOcG>; Wed, 22 May 2002 10:32:06 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39953 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314596AbSEVOcF>; Wed, 22 May 2002 10:32:05 -0400
Subject: Re: Have the 2.4 kernel memory management problems on large machines
To: alastair.stevens@mrc-bsu.cam.ac.uk (Alastair Stevens)
Date: Wed, 22 May 2002 15:52:20 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.44.0205221524130.1550-100000@gerber> from "Alastair Stevens" at May 22, 2002 03:29:37 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17AXTQ-0001uU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.4.19-pre kernel. Otherwise, the Red Hat patched kernel (which I
> believe still doesn't use Andrea's VM at all) ought to work well, with
> all their spiffy regression testing etc....

The Red Hat 7.3 kernel uses Rik van Riel's rmap and Andre Hedricks IDE
updates. It did indeed pass our stress testing and seems to perform very
well under memory contention and high shared page counts - the classic
desktop/developer set up.

Alan

