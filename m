Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291738AbSBHS7O>; Fri, 8 Feb 2002 13:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291746AbSBHS66>; Fri, 8 Feb 2002 13:58:58 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:64273 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291743AbSBHS5s>; Fri, 8 Feb 2002 13:57:48 -0500
Subject: Re: Problem with mke2fs on huge RAID-partition
To: pruegg@eproduction.ch (Peter H. =?iso-8859-1?Q?R=FCegg?=)
Date: Fri, 8 Feb 2002 18:18:15 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C640C90.E71E3F70@eproduction.ch> from "Peter H. =?iso-8859-1?Q?R=FCegg?=" at Feb 08, 2002 06:36:16 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ZFbD-0004TM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My problem is: If I start mke2fs [1] on the device, it writes everything
> down until "Writing Superblocks...". The system then completly hangs.
> And yes, I did wait long enough (well, at least I think 15 hours should
> be enough ;-)

More than enough

> Is there a limitation in the maximum size of a partition (well, 400 GB is
> not that small...), may it be a (known) problem of mke2fs or the particular
> Kernel-Version, or does anyone have any suggestions where else to seek?

The limit is about 1Tb currently. You are hitting something else, perhaps
a driver or VM problem ?
