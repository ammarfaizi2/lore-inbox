Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270645AbRIAMqq>; Sat, 1 Sep 2001 08:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270646AbRIAMqg>; Sat, 1 Sep 2001 08:46:36 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2833 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270645AbRIAMq3>; Sat, 1 Sep 2001 08:46:29 -0400
Subject: Re: ide problem on 2.2.17?
To: jens@gecius.de (Jens Gecius)
Date: Sat, 1 Sep 2001 13:49:35 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <874rqnf5hy.fsf@maniac.gecius.de> from "Jens Gecius" at Sep 01, 2001 08:41:13 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15dADP-0004y7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sep  1 02:07:46 torriac kernel: attempt to access beyond end of device
> Sep  1 02:07:46 torriac kernel: 03:02: rw=0, want=8421508, limit=779152

Unmount the file system concerned and run fsck on it - it does look like
some kind of corruption has occured

> What is going on?? I found something for older 2.2 kernels (broken ide
> driver), but 2.2.17?

Im not sure what is going on - there are an awful lot of possibilities but
the first step is to fix it on the disk.

Alan
