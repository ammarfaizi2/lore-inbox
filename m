Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285589AbSBCA7R>; Sat, 2 Feb 2002 19:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285829AbSBCA66>; Sat, 2 Feb 2002 19:58:58 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47365 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284305AbSBCA6k>; Sat, 2 Feb 2002 19:58:40 -0500
Subject: Re: [PATCH] Generic HDLC patch for 2.5.3
To: garzik@havoc.gtf.org (Jeff Garzik)
Date: Sun, 3 Feb 2002 00:46:28 +0000 (GMT)
Cc: khc@pm.waw.pl (Krzysztof Halasa), linux-kernel@vger.kernel.org,
        torvalds@transmeta.com (Linus Torvalds), davem@redhat.com
In-Reply-To: <20020202190242.C1740@havoc.gtf.org> from "Jeff Garzik" at Feb 02, 2002 07:02:42 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16XAnc-00010K-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It adds undiscussed networking changed which I very much doubt DaveM
> would approve of, and I do not approve of:  SIOCDEVICE is far too
> generic for inclusion, and it adds a structure for passing untyped
> data which is very definitely non-portable.

You need a very generic structure for WAN interfaces because they have
ridiculously large numbers of configurable options. These changes were
discussed over a year ago.

I agree with the comment about untyped data. That does want to be cleaned
up a chunk more. 
