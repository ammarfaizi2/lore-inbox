Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310651AbSCHBzQ>; Thu, 7 Mar 2002 20:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310640AbSCHBzH>; Thu, 7 Mar 2002 20:55:07 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:10504 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310646AbSCHByy>; Thu, 7 Mar 2002 20:54:54 -0500
Subject: Re: [PATCH] Submitting PROMISE IDE Controllers Driver Patch
To: hanky@promise.com.tw (Hank Yang)
Date: Fri, 8 Mar 2002 02:10:03 +0000 (GMT)
Cc: arjanv@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <00b901c1c642$e7b6e9b0$59cca8c0@hank> from "Hank Yang" at Mar 08, 2002 09:45:15 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16j9pb-0004dV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     That's because the linux-kernel misunderstand the raid controller
> to IDE controller. If do so, The raid driver will be unstable when
> be loaded.
>     So we must to prevent the raio controller to be as IDE controller
> here.

The ataraid driver in the standard kernel requires the IDE drive is seen
by the ide layer otherwise ataraid cannot bind it into a raid module

Alan
