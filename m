Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292015AbSBOAeE>; Thu, 14 Feb 2002 19:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292032AbSBOAdy>; Thu, 14 Feb 2002 19:33:54 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28681 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292015AbSBOAdf>; Thu, 14 Feb 2002 19:33:35 -0500
Subject: Re: Problems with VM
To: ccroswhite@get2chip.com
Date: Fri, 15 Feb 2002 00:47:24 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C6C53C0.E7562704@get2chip.com> from "ccroswhite@get2chip.com" at Feb 14, 2002 04:18:08 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16bWX6-0001hc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> as 'normal' ran.  Consequently, I will have a machine that has 5M
> 'normal' RAM, 800M 'cache' RAM and the reset coming out of swap space.
> I need this 'cache' RAM placed back into the available RAM pool to be
> used by applications.  Is there a patch/kernel configuration that I can
> change this behavior?

2.4.18-rc1 should fix the worst of that. The rmap patches in 2.4.18-ac
definitely fix it
