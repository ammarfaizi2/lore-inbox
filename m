Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291625AbSBNMfC>; Thu, 14 Feb 2002 07:35:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291608AbSBNMem>; Thu, 14 Feb 2002 07:34:42 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18962 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291618AbSBNMef>; Thu, 14 Feb 2002 07:34:35 -0500
Subject: Re: weird system load (2.4.18-pre3)
To: Teodor.Iacob@astral.kappa.ro
Date: Thu, 14 Feb 2002 12:48:24 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.31.0202141244060.7065-100000@linux.kappa.ro> from "Teodor Iacob" at Feb 14, 2002 12:48:39 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16bLJI-0008LG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a linux router running 2.4.18-pre3 kernel and I've got the
> following problem with it:
> 
> It doesn't have free cpu, more than 75% of the resources go to system:

Well its paging somewhat which suprises me, but unless your disks are in PIO
mode I would not expect it to account for that.

What network and disk drivers are you using ?

> ext3 mounted, and we had a lot of problems with ext3 when reaching maximum
> capacity ( after reboot had a lot of fatal errors ), but that seemed to

Thats not a good sign for trusting the machine either

> passed, and now we are getting this unusual load, plus the system is not
> so reponsive.

Not so responsive as when ?  also what is in the dmesg log ?
