Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945923AbWBCTpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945923AbWBCTpl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 14:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945924AbWBCTpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 14:45:41 -0500
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:18319 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP
	id S1945923AbWBCTpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 14:45:40 -0500
Date: Fri, 3 Feb 2006 20:45:30 +0100 (CET)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: Phillip Susi <psusi@cfl.rr.com>
cc: Roger Heflin <rheflin@atipa.com>, "'Bill Davidsen'" <davidsen@tmr.com>,
       "'Cynbe ru Taren'" <cynbe@muq.org>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       "'Salyzyn, Mark'" <mark_salyzyn@adaptec.com>
Subject: Re: FYI: RAID5 unusably unstable through 2.6.14
In-Reply-To: <43E3B1D7.4090308@cfl.rr.com>
Message-ID: <Pine.LNX.4.60.0602032044060.26896@kepler.fjfi.cvut.cz>
References: <EXCHG2003KfYDovvQ0P000011f7@EXCHG2003.microtech-ks.com>
 <Pine.LNX.4.60.0602032010430.24081@kepler.fjfi.cvut.cz> <43E3B1D7.4090308@cfl.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Feb 2006, Phillip Susi wrote:

> Martin Drab wrote:
> > S.M.A.R.T. should be able to do this. But last time I've checked it wasn't
> > working with Linux and SCSI/SATA. Is this working now?
> 
> Yes, it is working now.  The smartutils package returns all kinds of handy
> information from the drive and can force the drive to perform a low level disk
> check on request.  It likely won't pass through a hardware raid controller
> however. 

Yes, that may be another issue. It depend's on whether AACRAID is ready 
for that or not. (Adaptec declares that the controller is SMART capable.)

Martin
