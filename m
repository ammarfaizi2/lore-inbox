Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129949AbRBSQFn>; Mon, 19 Feb 2001 11:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129935AbRBSQFd>; Mon, 19 Feb 2001 11:05:33 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:24849 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129816AbRBSQFU>; Mon, 19 Feb 2001 11:05:20 -0500
Subject: Re: quotaon -guav on 2.4.1-ac15
To: lech.szychowski@pse.pl
Date: Mon, 19 Feb 2001 16:05:35 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010219130044.D13053@lech.pse.pl> from "Lech Szychowski" at Feb 19, 2001 01:00:44 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Usok-0003lO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > quotaon: using /home/vhosts/b/quota.user on /dev/sda3: Invalid argument
> > quotaon: using /home/vhosts/a/quota.user on /dev/sdb1: Invalid argument
> 
> I believe -ac family has Jan Kara quota patches and
> therefore you need his quota-3 utilites, avaliable from
> ftp://atrey.karlin.mff.cuni.cz/pub/local/jack/quota/utils

Yep. This is neccessary because the Linux base tree quota code as well as
being buggy (which can be fixed without tool changes) is 16bit uid so 
rather useless in the real world. And fixing that _does_ need the new tools
as well as the kernel patches Jan wrote which are integrated in -ac
