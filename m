Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270203AbRHWTol>; Thu, 23 Aug 2001 15:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270221AbRHWTnx>; Thu, 23 Aug 2001 15:43:53 -0400
Received: from pD9532DF4.dip.t-dialin.net ([217.83.45.244]:18187 "EHLO
	Marvin.DL8BCU.ampr.org") by vger.kernel.org with ESMTP
	id <S270203AbRHWTna>; Thu, 23 Aug 2001 15:43:30 -0400
Date: Thu, 23 Aug 2001 19:43:15 +0000
From: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
To: Ajit Jena <ajit@cc.iitb.ac.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Quantum DLT 4000 issues
Message-ID: <20010823194314.B8708@Marvin.DL8BCU.ampr.org>
Reply-To: dl8bcu@dl8bcu.de
Mail-Followup-To: Ajit Jena <ajit@cc.iitb.ac.in>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.33.0108232119510.12312-100000@indra.cc.iitb.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.GSO.4.33.0108232119510.12312-100000@indra.cc.iitb.ernet.in>; from ajit@cc.iitb.ac.in on Thu, Aug 23, 2001 at 09:22:39PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2001 at 09:22:39PM +0530, Ajit Jena wrote:
> 
> Hi All,
> 
> I need your expert advice on the following issue:
> 
> I saw some messages on the Linux kernel mailing list about DLT 4000
> tape drives.
> 
> We have a Quantum DLT 4000 1/15 drive connected to an HP9000 system.
> This is a SCSI device connected on the Wide SCSI port. I have all kinds
> of driver problems on the HP system. My tar backups abort randomly saying
> media error.

Did you check new cartriges? Media errors indicate defective tape material.
Maybe use a cleaning tape.

> 
> I was wondering if I can connect the same drive to a Linux box having
> wide SCSI interface. Do u think this is a workable proposition ? What
> extra hardware/software I need to procure ? Please advise.

It should work just fine as an ordinary /dev/st* device. We have a DLT
drive with a small (5 cartriges) loader system running at work. I think
it's also a Quantum.

> 
> Thanks for your time.
> 
> Regards.
> 
> --ajit

Bye,
Thorsten

-- 
| Thorsten Kranzkowski        Internet: dl8bcu@dl8bcu.de                      |
| Mobile: ++49 170 1876134       Snail: Niemannsweg 30, 49201 Dissen, Germany |
| Ampr: dl8bcu@db0lj.#rpl.deu.eu, dl8bcu@marvin.dl8bcu.ampr.org [44.130.8.19] |
