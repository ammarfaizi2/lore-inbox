Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311275AbSCQD03>; Sat, 16 Mar 2002 22:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311277AbSCQD0T>; Sat, 16 Mar 2002 22:26:19 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37390 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311275AbSCQD0G>; Sat, 16 Mar 2002 22:26:06 -0500
Subject: Re: /dev/md0: Device or resource busy
To: dean-list-linux-kernel@arctic.org (dean gaudet)
Date: Sun, 17 Mar 2002 03:41:59 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        mingo@redhat.com
In-Reply-To: <Pine.LNX.4.33.0203161911560.7016-100000@twinlark.arctic.org> from "dean gaudet" at Mar 16, 2002 07:17:51 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16mRYV-000853-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i just tried a "linux init=/bin/sh" boot, and it's still saying Device or
> resource busy:
> 
> init-2.05a# raidstop /dev/md0
> md: md0 still in use.
> /dev/md0: Device or resource busy
> init-2.05a# mount /proc

Duplicated. Seems the md code deos indeed have a bug there

