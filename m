Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278842AbRJaKjF>; Wed, 31 Oct 2001 05:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279961AbRJaKiz>; Wed, 31 Oct 2001 05:38:55 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33549 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278842AbRJaKip>; Wed, 31 Oct 2001 05:38:45 -0500
Subject: Re: Oops msg after upgrading to 2.4.10
To: krajput@softhome.net
Date: Wed, 31 Oct 2001 10:46:11 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011031060043.14799.qmail@softhome.net> from "krajput@softhome.net" at Oct 31, 2001 06:00:43 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ysst-0003Fg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have tried to upgrade my Linux 7.1 (kernel version 2.4.2) to kernel
> version 2.4.10 but to no avail. The kernel does install but fails to load
> the USB uhci subsytem. Infact when i do "lsmod" after the upgrade it shows
> me an empty table. Here are the steps that i undertook for the total
> upgrade

You need the -ac tree for working USB locking, even as of 2.4.14pre
