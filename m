Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312560AbSGIKSW>; Tue, 9 Jul 2002 06:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313477AbSGIKSV>; Tue, 9 Jul 2002 06:18:21 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23055 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312560AbSGIKSU>; Tue, 9 Jul 2002 06:18:20 -0400
Subject: Re: DELL array controller access.
To: austin@digitalroadkill.net (Austin Gonyou)
Date: Tue, 9 Jul 2002 11:10:56 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), Matt_Domsch@Dell.com,
       dtroth@bellsouth.net, linux-kernel@vger.kernel.org
In-Reply-To: <1026166417.16788.0.camel@UberGeek> from "Austin Gonyou" at Jul 08, 2002 05:13:37 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17RrxQ-0004XB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I know at a minimum...those cards can be put into a 154x mode, so it
> will work. I remember that NetWare needed this feature.

If they are AHA147x based then the 154x mode has emulation errors and Linux
specifically avoids using 154x drivers on them.

