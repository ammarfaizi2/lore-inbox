Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310964AbSCHRTz>; Fri, 8 Mar 2002 12:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310965AbSCHRTp>; Fri, 8 Mar 2002 12:19:45 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59149 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310964AbSCHRTa>; Fri, 8 Mar 2002 12:19:30 -0500
Subject: Re: linux 2.4.18 fails to load static /sbin/init
To: androsyn@ratbox.org (Aaron Sethman)
Date: Fri, 8 Mar 2002 17:34:53 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0203081218200.6974-100000@simon.ratbox.org> from "Aaron Sethman" at Mar 08, 2002 12:20:12 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16jOGb-0006sE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I noticed this problem when trying to boot 2.4.18 on a Netra t1 200.
> Basically what will happen is the kernel will mount / read-only, then try
> to load /sbin/init, at which point it hangs.  If I a dynamically linked
> wrapper around /sbin/init then all is happy and the system boots fine.
> 
> Any ideas or clues?

Known bug with sparc + static binaries. Use 2.4.19pre1, or if you want
2.4.18 just extract the binary loader patch from 2.4.19pre1
