Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285149AbRLFO0T>; Thu, 6 Dec 2001 09:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285153AbRLFO0O>; Thu, 6 Dec 2001 09:26:14 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:53516 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285149AbRLFOZ4>; Thu, 6 Dec 2001 09:25:56 -0500
Subject: Re: Kernel freezing....
To: jcarminati@yahoo.com (Jorge Carminati)
Date: Thu, 6 Dec 2001 14:35:04 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011206141602.88142.qmail@web13901.mail.yahoo.com> from "Jorge Carminati" at Dec 06, 2001 06:16:02 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-Id: <E16Bzc9-0001pF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> installed two times Red Hat in this notebook during this week, and no
> freeze was suffered during the whole installation process, which is a
> process that as you know requires almost an hour to complete.
> 
> I´m just asking why the kernel doesn´t freeze during the installation
> process (which it is supposed to run Linux I suspect :) ) and just
> after booting and typing some commands in init 1 mode, it freezes;
> quite strange. 

At least one possible cause is that the runtime kernels will use APM power
management and other facilities that the install kernel intentionally avoids
because a tiny number of boxes have it broken.

You can boot with extra boot options (apm=off I believe it is) to disable
APM use.
