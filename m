Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWAQQef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWAQQef (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 11:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWAQQef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 11:34:35 -0500
Received: from outgoing.smtp.agnat.pl ([193.239.44.83]:17683 "EHLO
	outgoing.smtp.agnat.pl") by vger.kernel.org with ESMTP
	id S932161AbWAQQee convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 11:34:34 -0500
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: Sebastian Kuzminsky <seb@highlab.com>
Subject: Re: sata_mv important note
Date: Tue, 17 Jan 2006 17:34:25 +0100
User-Agent: KMail/1.9.1
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <43CD07D5.30302@pobox.com> <E1EytdC-0006DE-IS@highlab.com>
In-Reply-To: <E1EytdC-0006DE-IS@highlab.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601171734.25598.arekm@pld-linux.org>
X-Authenticated-Id: arekm
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 January 2006 17:24, Sebastian Kuzminsky wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> > For sata_mv users, you should be aware of three things:
> >
> > 1) The Marvell driver is experimental, and not yet considered ready for
> > production use.  As Kconfig notes: HIGHLY EXPERIMENTAL.
>
> Right, understood.

I'm using:

03:03.0 SCSI storage controller: Marvell Technology Group Ltd. MV88SX6041 
4-port SATA II PCI-X Controller (rev 07)

but with http://www.keffective.com/mvsata/FC3/mvSata-3.4.2a-patched.tbz driver
and it works nicely (+ 2.8GHz Xeon HT, smp kernel). I was quite suprised to 
see that there are no problems with it in typical usage (while I'm sure that 
this driver is far away from kernel standards).

-- 
Arkadiusz Mi¶kiewicz                    PLD/Linux Team
http://www.t17.ds.pwr.wroc.pl/~misiek/  http://ftp.pld-linux.org/
