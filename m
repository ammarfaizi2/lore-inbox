Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280727AbRKTJEW>; Tue, 20 Nov 2001 04:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280733AbRKTJEN>; Tue, 20 Nov 2001 04:04:13 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12037 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280727AbRKTJEC>; Tue, 20 Nov 2001 04:04:02 -0500
Subject: Re: MP FP struct in the EBDA
To: zwane@linux.realnet.co.sz (Zwane Mwaikambo)
Date: Tue, 20 Nov 2001 09:11:49 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <Pine.LNX.4.33.0111200814170.30806-100000@netfinity.realnet.co.sz> from "Zwane Mwaikambo" at Nov 20, 2001 08:17:30 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1666wX-0000yo-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "If it is an SMP machine we should know now, unless the
> configuration is in an EISA/MCA bus machine with an extended bios data
> area."

Yes that was fixed.

> I'd presume this statement isn't true today, e.g. one of the IBM Netfinity
> boxes here (3500M20) has the MP tables in the EBDA. Also how come we
> search the whole EBDA (4k)? Whilst the MP 1.4 spec sheet says search the
> first kilobyte only.

We used to search the last 4K of RAM in the low 640Kb, it looks like that
was never changed when we began using the EBDA pointer properly. 
