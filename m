Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291088AbSCSS6p>; Tue, 19 Mar 2002 13:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291102AbSCSS6f>; Tue, 19 Mar 2002 13:58:35 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:5902 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291088AbSCSS6W>; Tue, 19 Mar 2002 13:58:22 -0500
Subject: Re: 2.5.7 make modules_install error (oss)
To: jjs@lexus.com (J Sloan)
Date: Tue, 19 Mar 2002 19:14:15 +0000 (GMT)
Cc: Wayne.Brown@altec.com, linux-kernel@vger.kernel.org
In-Reply-To: <3C97889B.6060301@lexus.com> from "J Sloan" at Mar 19, 2002 10:51:07 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16nP3n-0008Uv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Agreed, the oss drivers should _at least_
> be maintained as an alternative, e.g. for
> those of us who want reliable sound with
> *low latency*

Not really. Well not unless you wish to volunteer.

> I haven't checked lately, but not too long
> ago the alsa drivers were found to be one
> of the worst sources of latency in the kernel.

So fix it. On an SMP box the mess the oss drivers make is very visible
because its all running under lock_kernel
