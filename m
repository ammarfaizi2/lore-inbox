Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131094AbQL2MGR>; Fri, 29 Dec 2000 07:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130290AbQL2MGH>; Fri, 29 Dec 2000 07:06:07 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:7942 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131092AbQL2MFy>; Fri, 29 Dec 2000 07:05:54 -0500
Subject: Re: linux 2.2.19pre and thttpd (VM-global problem?)
To: pegasus@telemach.net (Jure Pecar)
Date: Fri, 29 Dec 2000 11:37:46 +0000 (GMT)
Cc: andrea@suse.de (Andrea Arcangeli), linux-kernel@vger.kernel.org,
        jef@acme.com
In-Reply-To: <3A4C4E16.52AAAFE1@telemach.net> from "Jure Pecar" at Dec 29, 2000 09:40:54 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Bxr2-00058E-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> At the moment it is 2.2.18 + all pathces that can be found at
> www.linuxraid.org and ide patch 2.2.18.1221, but i first spotted this

If you applied raid-0.90 and VM_global did you sort out the fact both of
them try to use the same free bit for extra buffer flags ?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
