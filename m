Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293015AbSCAMRd>; Fri, 1 Mar 2002 07:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293037AbSCAMRX>; Fri, 1 Mar 2002 07:17:23 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:36868 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293015AbSCAMRK>; Fri, 1 Mar 2002 07:17:10 -0500
Subject: Re: [PATCH] bluesmoke/MCE support optional
To: mfedyk@matchmail.com (Mike Fedyk)
Date: Fri, 1 Mar 2002 12:31:18 +0000 (GMT)
Cc: p_gortmaker@yahoo.com (Paul Gortmaker), marcelo@conectiva.com.br,
        alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20020301024710.GF2711@matchmail.com> from "Mike Fedyk" at Feb 28, 2002 06:47:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16gmBy-0003V5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +  ranging from a warning message on the console, to halting the machine.
> > +  Your processor must be a Pentium or newer to support this - check the 
> > +  flags in /proc/cpuinfo for mce.  Note that some older Pentium systems
> > +  have a design flaw which leads to false MCE events - for these and
> > +  old non-MCE processors (386, 486), say N.  Otherwise say Y.

Its not necessary to say N. On a pentium box with the newer MCE setup code
you must force MCE on. On non MCE capable CPU's we just dont set it up.
