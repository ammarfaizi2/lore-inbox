Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317580AbSGEVS1>; Fri, 5 Jul 2002 17:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317582AbSGEVS0>; Fri, 5 Jul 2002 17:18:26 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:42500 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317580AbSGEVSZ>; Fri, 5 Jul 2002 17:18:25 -0400
Subject: Re: prevent breaking a chroot() jail?
To: vherva@niksula.hut.fi (Ville Herva)
Date: Fri, 5 Jul 2002 22:15:07 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020705184503.GQ1548@niksula.cs.hut.fi> from "Ville Herva" at Jul 05, 2002 09:45:03 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17QaPz-0004Db-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ISTR UML had some security problems (guest processes being able to disrupt
> host processes or just guest processes being able to disrupt other guest
> processes). Have those been resolved yet? 

Yes

> Do people use it in production? Last I heard someone had evaluated it, it
> had ended up consuming way too much CPU per "jail" for whatever reason.
> Perhaps things are better already...

It needs some work, and probably ultimately a couple of assists to
do sigaltmm and VM style pagex
