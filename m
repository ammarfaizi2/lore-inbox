Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268174AbRGWJcr>; Mon, 23 Jul 2001 05:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268169AbRGWJch>; Mon, 23 Jul 2001 05:32:37 -0400
Received: from energy.pdb.sbs.de ([192.109.2.19]:31751 "EHLO energy.pdb.sbs.de")
	by vger.kernel.org with ESMTP id <S268162AbRGWJc3>;
	Mon, 23 Jul 2001 05:32:29 -0400
Date: Mon, 23 Jul 2001 11:34:09 +0200 (CEST)
From: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
To: Andreas Jaeger <aj@suse.de>
cc: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Problem: Large file I/O waits (almost) forever
In-Reply-To: <hopuas9feq.fsf@gee.suse.de>
Message-ID: <Pine.LNX.4.30.0107231131110.24403-100000@biker.pdb.fsc.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


> Under what filesystem and with what kind of hardware did you run this?

Both source and destination were on a aingle ext2 file system on a
Adaptec 29160 SCSI controller. I was using the aic7xxx driver versiuon
6.2.0-beta1 from http://people.freebsd.org/~gibbs/linux which is needed to
have this controller run stably under IA64 (actually the test was intended
to check the stability of this driver).

Martin

-- 
Martin Wilck     <Martin.Wilck@fujitsu-siemens.com>
FSC EP PS DS1, Paderborn      Tel. +49 5251 8 15113



