Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129055AbQKGSQW>; Tue, 7 Nov 2000 13:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129116AbQKGSQM>; Tue, 7 Nov 2000 13:16:12 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:42506 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129055AbQKGSQF>; Tue, 7 Nov 2000 13:16:05 -0500
Subject: Re: Broken colors on console with 2.4.0-textXX
To: jsimmons@suse.com (James Simmons)
Date: Tue, 7 Nov 2000 18:15:59 +0000 (GMT)
Cc: richard.guenther@student.uni-tuebingen.de (Richard Guenther),
        tytso@mit.edu, linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <Pine.LNX.4.21.0011070957370.2811-100000@euclid.oak.suse.com> from "James Simmons" at Nov 07, 2000 09:58:46 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13tDHs-0007cs-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Actually I just thought about it. Do you DRI running. When you have DRI
> enabled you shouldn't VT switch. It is a design flaw in DRI and the
> console system :-(. Disable DRI you you will be fine.

The theory behind DRI covers this fine. If its breaking fix the bugs in the
Xserver and DRI code. X gets to pick when it gives the console back

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
