Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272871AbRIGWOC>; Fri, 7 Sep 2001 18:14:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272872AbRIGWNw>; Fri, 7 Sep 2001 18:13:52 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57609 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272871AbRIGWNk>; Fri, 7 Sep 2001 18:13:40 -0400
Subject: Re: /proc/cpuinfo bad cache info
To: hpa@zytor.com (H. Peter Anvin)
Date: Fri, 7 Sep 2001 23:17:53 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9nb2uh$346$1@cesium.transmeta.com> from "H. Peter Anvin" at Sep 07, 2001 11:16:49 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15fTwg-0002gV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We already DO report the information we care about -- the SMP
> weighting value -- and thus the code is correct.  The value indicates
> how much data is localized to that CPU and therefore how expensive it
> is to reschedule a process elsewhere.

There are plenty of other reasons for wanting to know more, eg picking which
video encode tables to use - but I still agree they belong in user space
since cpuid is available from user space too
